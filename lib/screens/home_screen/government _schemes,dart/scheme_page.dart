import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/mapfor_government_schemes.dart';

class SchemePage extends StatefulWidget {
  const SchemePage({
    super.key,
    required this.schemes,
    required this.title,
    required this.image,
  });

  @override
  State<SchemePage> createState() => _SchemePageState();
  final String schemes;
  final String title;
  final String image;
}

class _SchemePageState extends State<SchemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover),
                ),
              ),
              Text(
                widget.schemes,
                style: GoogleFonts.lato(
                    color: Colors.green[900], fontSize: 14),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
