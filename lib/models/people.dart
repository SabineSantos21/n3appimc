import 'package:cloud_firestore/cloud_firestore.dart';

class People {
  String id;
  String name;
  double height;
  double weight;
  double imc;

  People({this.id = '', required this.name, required this.height, required this.weight, this.imc = 0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'imc': imc
    };
  }

  static People fromJson(Map<String, dynamic> json) {
    return People(
        id: json['id'],
        name: json['name'],
        height: json['height'],
        weight: json['weight'],
        imc: json['imc']
    );
  }
}