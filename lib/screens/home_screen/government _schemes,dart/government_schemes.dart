import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/mapfor_government_schemes.dart';
import 'package:krishi_mitra/screens/home_screen/government%20_schemes,dart/scheme_page.dart';

class GovernmentSchemes extends StatefulWidget {
  const GovernmentSchemes({super.key});

  @override
  State<GovernmentSchemes> createState() => _GovernmentSchemesState();
}

class _GovernmentSchemesState extends State<GovernmentSchemes> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("government".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ...List.generate(
                governmentTitles.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchemePage(
                          schemes:
                              governmentTitles[index]["schemes"].toString().tr,
                          title: governmentTitles[index]["title"].toString().tr,
                          image: governmentTitles[index]["photo"],
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
                        governmentTitles[index]["photo"] != null?
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 90,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  governmentTitles[index]["photo"],
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
                            governmentTitles[index]["title"].toString().tr,
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
