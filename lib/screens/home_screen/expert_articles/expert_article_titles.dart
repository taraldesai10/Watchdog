import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/mapfor_expert_articles.dart';

import 'expert_articles_detail.dart';

class ExpertArticles extends StatefulWidget {
  const ExpertArticles({super.key});

  @override
  State<ExpertArticles> createState() => _ExpertArticlesState();
}

class _ExpertArticlesState extends State<ExpertArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("expert articles".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ...List.generate(
                expertArticles.length,
                    (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpertArticlesDetail(
                          schemes:
                          expertArticles[index]["schemes"].toString().tr,
                          title: expertArticles[index]["title"].toString().tr,
                          image: expertArticles[index]["photo"],
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
                        expertArticles[index]["photo"] != null?
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 90,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  expertArticles[index]["photo"],
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
                            expertArticles[index]["title"].toString().tr,
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
