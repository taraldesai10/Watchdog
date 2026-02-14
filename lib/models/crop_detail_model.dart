class CropDetail {
  late String cropName;
  late String condition;
  late String date;
  late String acres;
  late String picture;
  late String name;
  late String userMobile;
  late String uid;
  late String image;
  CropDetail({
    required this.acres,
    required this.condition,
    required this.cropName,
    required this.date,
    required this.picture,
    required this.name,
    required this.userMobile,
    required this.uid,
    required this.image

  });
  factory CropDetail.fromJson(Map<String, dynamic> json) => CropDetail(
      acres: json["acres"],
      condition: json["condition"],
      cropName: json["cropName"],
      date: json["date"],
      picture: json["picture"],
      name: json["name"],
      userMobile: json["userMobile"],
      uid: json["uid"],
  image: json["image"]
  );
  Map<String, dynamic> toJson() => {
        "acres": acres,
        "condition": condition,
        "cropName": cropName,
        "date": date,
        "picture": picture,
        "name": name,
    "userMobile"  : userMobile,
        "uid": uid,
    "image" : image
      };
}
