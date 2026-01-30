using System;
using System.Drawing;
using Grasshopper;
using Grasshopper.Kernel;

namespace Watchdog
{
    public class WatchdogInfo : GH_AssemblyInfo
    {
        public override string Name => "Watchdog";

        //Return a 24x24 pixel bitmap to represent this GHA library.
        public override Bitmap Icon => null;

        //Return a short string describing the purpose of this GHA library.
        public override string Description => "";

        public override Guid Id => new Guid("0e50338f-d7b1-42f3-a3fb-eaad1d16584c");

        //Return a string identifying you or your company.
        public override string AuthorName => "Yifeng Peng";

        //Return a string representing your preferred contact details.
        public override string AuthorContact => "https://github.com/Yifeng-Dev";

        //Return a string representing the version.  This returns the same version as the assembly.
        public override string AssemblyVersion => GetType().Assembly.GetName().Version.ToString();
    }
}