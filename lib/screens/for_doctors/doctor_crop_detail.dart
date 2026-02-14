import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorCropDetailPage extends StatefulWidget {
  const DoctorCropDetailPage({
    super.key,
    required this.acres,
    required this.userName,
    required this.userMNumber,
    required this.userImage,
    required this.date,
    required this.cropName,
    required this.condition,
    required this.cropImage,
  });

  @override
  State<DoctorCropDetailPage> createState() => _DoctorCropDetailPageState();
  final String acres;
  final String condition;
  final String cropName;
  final String date;
  final String userImage;
  final String userName;
  final String cropImage;
  final String userMNumber;
}

class _DoctorCropDetailPageState extends State<DoctorCropDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.green[300],
                border: Border.all(color: Colors.green.shade900),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(widget.cropImage.toString()),
                    fit: BoxFit.cover),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Crop :",
                  style: GoogleFonts.lato(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.cropName,
                  style: GoogleFonts.lato(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Planted date :",
                  style: GoogleFonts.lato(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.date,
                  style: GoogleFonts.lato(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Acers :",
                  style: GoogleFonts.lato(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.acres,
                  style: GoogleFonts.lato(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Infection :",
                  style: GoogleFonts.lato(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.condition,
                  style: GoogleFonts.lato(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Mobile number :",
                  style: GoogleFonts.lato(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.userMNumber,
                  style: GoogleFonts.lato(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
