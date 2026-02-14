import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key, required this.news, required  this.title, required this.image});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
  final  String news;
  final String title;
  final String image;


}

class _NewsDetailState extends State<NewsDetail> {
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
                widget.news,
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
