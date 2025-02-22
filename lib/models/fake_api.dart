import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FakeApiState extends StatefulWidget {
  const FakeApiState({super.key});

  @override
  State<FakeApiState> createState() => _FakeApiStateState();
}

class _FakeApiStateState extends State<FakeApiState> {
  Future<FakeApiModel> getfakeapi() async {
    final response = await http.get(
      Uri.parse('https://webhook.site/87f28e92-16f7-4ad3-a532-67301a957c34'),
    );
    final content = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return FakeApiModel.fromJson(content);
    } else {
      return FakeApiModel.fromJson(content);
    }
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: getfakeapi(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data!.data![index].shop!.image
                                      .toString()),
                                ),
                                title: Text(snapshot
                                    .data!.data![index].shop!.name
                                    .toString()),
                                subtitle: Text(
                                  snapshot.data!.data![index].shop!.shopemail
                                      .toString(),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 1.5,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data!.data![index].images!.length,
                                  itemBuilder: (context, position) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          1.1,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            snapshot.data!.data![index]
                                                .images![position].url
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isClicked = !isClicked;
                                  setState(() {});
                                },
                                child: Icon(
                                  snapshot.data!.data![index].inWishlist ==
                                          isClicked
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: isClicked == false
                                      ? Colors.white
                                      : Colors.red,
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FakeApiModel {
  bool? success;
  String? message;
  List<Data>? data;

  FakeApiModel({
    required this.success,
    required this.message,
    required this.data,
  });

  FakeApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? sId;
  bool? onSale;
  int? salePercent;
  int? sold;
  bool? sliderNew;
  bool? sliderRecent;
  bool? sliderSold;
  String? date;
  String? title;
  Categories? categories;
  Subcat? subcat;
  Shop? shop;
  String? price;
  String? saleTitle;
  String? salePrice;
  String? description;
  String? color;
  String? size;
  bool? inWishlist;
  List<Images>? images;

  Data(
      {required this.sId,
      required this.onSale,
      required this.salePercent,
      required this.sold,
      required this.sliderNew,
      required this.sliderRecent,
      required this.sliderSold,
      required this.date,
      required this.title,
      required this.categories,
      required this.subcat,
      required this.shop,
      required this.price,
      required this.saleTitle,
      required this.salePrice,
      required this.description,
      required this.color,
      required this.size,
      required this.inWishlist,
      required this.images});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    onSale = json['on_sale'];
    salePercent = json['sale_percent'];
    sold = json['sold'];
    sliderNew = json['slider_new'];
    sliderRecent = json['slider_recent'];
    sliderSold = json['slider_sold'];
    date = json['date'];
    title = json['title'];
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
    subcat = json['subcat'] != null ? Subcat.fromJson(json['subcat']) : null;
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    price = json['price'];
    saleTitle = json['sale_title'];
    salePrice = json['sale_price'];
    description = json['description'];
    color = json['color'];
    size = json['size'];
    inWishlist = json['in_wishlist'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }
}

class Categories {
  String? sId;
  String? type;
  int? salePercent;
  String? date;
  String? name;
  String? image;

  Categories(
      {required this.sId,
      required this.type,
      required this.salePercent,
      required this.date,
      required this.name,
      required this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    salePercent = json['sale_percent'];
    date = json['date'];
    name = json['name'];
    image = json['image'];
  }
}

class Subcat {
  String? sId;
  String? type;
  int? salePercent;
  String? date;
  String? name;

  Subcat({
    required this.sId,
    required this.type,
    required this.salePercent,
    required this.date,
    required this.name,
  });

  Subcat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    salePercent = json['sale_percent'];
    date = json['date'];
    name = json['name'];
  }
}

class Shop {
  String? sId;
  bool? isActive;
  String? createdAt;
  String? name;
  String? description;
  String? shopemail;
  String? shopaddress;
  String? shopcity;
  String? userid;
  String? image;

  Shop(
      {required this.sId,
      required this.isActive,
      required this.createdAt,
      required this.name,
      required this.description,
      required this.shopemail,
      required this.shopaddress,
      required this.shopcity,
      required this.userid,
      required this.image});

  Shop.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isActive = json['is_active'];
    createdAt = json['created_At'];
    name = json['name'];
    description = json['description'];
    shopemail = json['shopemail'];
    shopaddress = json['shopaddress'];
    shopcity = json['shopcity'];
    userid = json['userid'];
    image = json['image'];
  }
}

class Images {
  String? id;
  String? url;

  Images({this.id, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }
}
