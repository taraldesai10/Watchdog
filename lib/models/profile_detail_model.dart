class ProfileDetailModel {
  late String name;
  late String phone;
  late String uid;
  late String image;

  ProfileDetailModel({required this.name,
    required this.phone,
    required this.uid,
    required this.image});

  factory ProfileDetailModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailModel(
        name: json["name"],
        phone: json["phone"],
        uid: json["uid"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "phone": phone,
        "uid": uid,
        "image": image,
      };
}

class ProfileDetailUpdateModel {
  late String image;
  late String name;

  ProfileDetailUpdateModel({required this.image, required this.name});

  factory ProfileDetailUpdateModel.fromJson(Map<String, dynamic> json)=>
      ProfileDetailUpdateModel(image: json["image"], name: json[ "name"]);
  Map<String,dynamic> toJson()=>{
    "image" : image,
    "name" : name
  };
}