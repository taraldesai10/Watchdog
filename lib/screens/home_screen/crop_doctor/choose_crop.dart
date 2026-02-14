import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/crop_doctor_maps.dart';
import 'package:krishi_mitra/screens/home_screen/crop_doctor/add_crop_detail.dart';

class ChooseCrop extends StatefulWidget {
  const ChooseCrop({super.key});
  static String? cropName;

  @override
  State<ChooseCrop> createState() => _ChooseCropState();
}

class _ChooseCropState extends State<ChooseCrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: Text("crop doctor".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 15,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
                children: [
                  ...List.generate(
                    chooseCrop.length,
                    (index) => GestureDetector(
                      onTap: () {
                        ChooseCrop.cropName = chooseCrop[index]["crop name"].toString().tr;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCropDetail(
                              image: chooseCrop[index]["image"],
                              name: chooseCrop[index]["crop name"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          image: DecorationImage(
                              image: AssetImage(
                                chooseCrop[index]["image"].toString().tr,
                              ),
                              fit: BoxFit.contain),
                        ),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 20,
                          width: double.infinity,
                          decoration:
                              BoxDecoration(color: Colors.green.shade900),
                          child: Text(
                            chooseCrop[index]["crop name"].toString().tr,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
