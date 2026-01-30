// SPDX-License-Identifier: MIT
// Watchdog - Grasshopper solution timeout watchdog component
// Copyright (c) 2026 Yifeng Peng
//
using System;
using System.Drawing;
using System.Timers;
using System.Reflection;
using System.IO;
using Grasshopper.Kernel;
using Rhino;

namespace Watchdog
{
    /// <summary>
    /// Solution timeout watchdog. Aborts GH computation if it exceeds the specified limit.
    /// </summary>
    public class WatchdogComponent : GH_Component
    {
        private System.Timers.Timer _timer;
        private int _timeoutLimit = 10000;
        private bool _isMonitoring;

        private static Bitmap _icon;
        private const string IconResourceName = "Watchdog.Resources.WatchdogIcon24.png";

        public WatchdogComponent()
          : base("Watchdog", "Watchdog",
              "Monitors solution time and aborts execution if timeout is reached.",
              "Params", "Util")
        {
        }

        protected override void RegisterInputParams(GH_InputParamManager pManager)
        {
            pManager.AddBooleanParameter("Active", "On", "Enable Watchdog", GH_ParamAccess.item, true);
            pManager.AddIntegerParameter("MaxSec", "Lim", "Timeout limit in seconds", GH_ParamAccess.item, 10);
        }

        protected override void RegisterOutputParams(GH_OutputParamManager pManager)
        {
            pManager.AddTextParameter("Info", "I", "Status info", GH_ParamAccess.item);
        }

        protected override void SolveInstance(IGH_DataAccess DA)
        {
            bool active = false;
            int maxSec = 10;

            if (!DA.GetData(0, ref active)) return;
            if (!DA.GetData(1, ref maxSec)) return;

            _timeoutLimit = maxSec * 1000;

            if (active && !_isMonitoring)
                StartWatchdog();
            else if (!active && _isMonitoring)
                StopWatchdog();

            DA.SetData(0, _isMonitoring ? $"Monitoring ({maxSec}s)" : "Paused");
        }

        #region Core

        private void StartWatchdog()
        {
            if (_isMonitoring) return;

            var doc = OnPingDocument();
            if (doc == null) return;

            doc.SolutionStart += OnSolutionStart;
            doc.SolutionEnd += OnSolutionEnd;
            _isMonitoring = true;
        }

        private void StopWatchdog()
        {
            if (!_isMonitoring) return;

            var doc = OnPingDocument();
            if (doc != null)
            {
                doc.SolutionStart -= OnSolutionStart;
                doc.SolutionEnd -= OnSolutionEnd;
            }

            KillTimer();
            _isMonitoring = false;
        }

        private void KillTimer()
        {
            if (_timer == null) return;

            _timer.Stop();
            _timer.Elapsed -= OnTimeout;
            _timer.Dispose();
            _timer = null;
        }

        private void OnSolutionStart(object sender, GH_SolutionEventArgs e)
        {
            if (Locked) return;

            KillTimer();
            _timer = new System.Timers.Timer(_timeoutLimit) { AutoReset = false };
            _timer.Elapsed += OnTimeout;
            _timer.Start();

            RhinoApp.InvokeOnUiThread(new Action(() =>
            {
                Message = string.Empty;
            }));
        }

        /// <remarks>Kill timer on normal completion to prevent false abort.</remarks>
        private void OnSolutionEnd(object sender, GH_SolutionEventArgs e)
        {
            KillTimer();
        }

        private void OnTimeout(object sender, ElapsedEventArgs e)
        {
            var doc = OnPingDocument();
            if (doc == null || doc.SolutionState != GH_ProcessStep.Process) return;

            doc.RequestAbortSolution();

            RhinoApp.InvokeOnUiThread(new Action(() =>
            {
                Message = "ABORTED";
                OnDisplayExpired(true);
            }));
        }

        #endregion

        #region Lifecycle

        public override void RemovedFromDocument(GH_Document document)
        {
            StopWatchdog();
            base.RemovedFromDocument(document);
        }

        public override void DocumentContextChanged(GH_Document document, GH_DocumentContext context)
        {
            if (context == GH_DocumentContext.Close)
                StopWatchdog();

            base.DocumentContextChanged(document, context);
        }

        #endregion

        #region Resources

        protected override Bitmap Icon
        {
            get
            {
                if (_icon == null)
                    _icon = LoadEmbeddedBitmap(IconResourceName);
                return _icon;
            }
        }

        /// <remarks>Clone bitmap to detach from stream lifetime.</remarks>
        private static Bitmap LoadEmbeddedBitmap(string resourceName)
        {
            try
            {
                Assembly asm = Assembly.GetExecutingAssembly();
                using (Stream s = asm.GetManifestResourceStream(resourceName))
                {
                    if (s == null) return null;

                    using (Bitmap tmp = new Bitmap(s))
                    {
                        return new Bitmap(tmp);
                    }
                }
            }
            catch
            {
                return null;
            }
        }

        public override Guid ComponentGuid => new Guid("cc53507d-ec29-43a8-9424-a42f9b48c6f6");

        #endregion
    }
}
