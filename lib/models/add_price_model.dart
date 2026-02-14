class AddPriceModel {
  late String price;
  // late List date;

  AddPriceModel({required this.price,
    // required this.date
  });

  factory AddPriceModel.fromJson(Map<String, dynamic> Json) => AddPriceModel(
        price: Json["price"],
        // date: Json["date"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        // "date": date,
      };
}
