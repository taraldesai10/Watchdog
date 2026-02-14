import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/screens/home_screen/expert_articles/expert_article_titles.dart';
import 'package:krishi_mitra/screens/home_screen/government%20_schemes,dart/government_schemes.dart';

class GovernmentSchemesShort extends StatefulWidget {
  const GovernmentSchemesShort({super.key});

  @override
  State<GovernmentSchemesShort> createState() => _GovernmentSchemesShortState();
}

class _GovernmentSchemesShortState extends State<GovernmentSchemesShort> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GovernmentSchemes(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 30),
        margin: EdgeInsets.symmetric(vertical: 20),
        height: 180,
        decoration: BoxDecoration(
            color: Colors.green[200], borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 90,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/government_schemes_image/fishermen.jpg",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Text(
                    "fisherman".tr,
                    style: GoogleFonts.lato(
                        color: Colors.green[900], fontSize: 15),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Text(
                "tap".tr,
                style: GoogleFonts.lato(color:Colors.green[50]),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ExpertAdviceShortCut extends StatefulWidget {
  const ExpertAdviceShortCut({super.key});

  @override
  State<ExpertAdviceShortCut> createState() => _ExpertAdviceShortCutState();
}

class _ExpertAdviceShortCutState extends State<ExpertAdviceShortCut> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertArticles(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 30),

        height: 180,
        decoration: BoxDecoration(
            color: Colors.green[200], borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 90,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/expert_artical_images/biofertilizer.jpeg",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Text(
                    "a-Use of Biofertilizers in Agriculture".tr,
                    style: GoogleFonts.lato(
                        color: Colors.green[900], fontSize: 15),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Text(
                "tap".tr,
                style: GoogleFonts.lato(color:Colors.green[50]),
              ),
            )
          ],
        ),
      ),
    );;
  }
}
