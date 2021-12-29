//freezed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product {
  var id;
  var price;
  var imageURL;
  var name;
  var company;
  var isChecked = false;

  Product({this.id, this.price, this.imageURL, this.name, this.company});

  factory Product.fromSnapShot(DocumentSnapshot ds) {
    return Product(
      id: ds.id,
      company: ds['brand'],
      imageURL: ds['image'],
      name: ds['name'],
      price: ds['price'],
    );
  }
}
