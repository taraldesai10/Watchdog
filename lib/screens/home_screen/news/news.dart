import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/news_map.dart';
import 'package:krishi_mitra/screens/home_screen/news/news_details.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("news".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ...List.generate(
                newsDetail.length,
                    (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetail(
                          news:
                          newsDetail[index]["news"].toString().tr,
                          title: newsDetail[index]["title"].toString().tr,
                          image: newsDetail[index]["photo"],
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[300],
                    ),
                    child: Row(
                      children: [
                        newsDetail[index]["photo"] != null?
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 90,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  newsDetail[index]["photo"],
                                ),
                                fit: BoxFit.cover),
                          ),
                        ):Container(
                          alignment:Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 90,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          width: 170,
                          child: Text(
                            newsDetail[index]["title"].toString().tr,
                            style: GoogleFonts.lato(
                                color: Colors.green[900], fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
