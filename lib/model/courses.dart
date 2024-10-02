import 'package:prueba_tecnica/model/mertorias.dart';

class Course {
  final String categoryKey; 
  final String description; 
  final String detail; 
  final String image; 
  final String title; 
  final List<Characteristic> characteristics; // Agregado

  Course({
    required this.categoryKey,
    required this.description,
    required this.detail,
    required this.image,
    required this.title,
    required this.characteristics, // Agregado
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var characteristicList = json['characteristics'] as List;
    List<Characteristic> characteristics = 
        characteristicList.map((i) => Characteristic.fromJson(i)).toList();

    return Course(
      categoryKey: json['categoryKey'] ?? '',
      description: json['description'] ?? '',
      detail: json['detail'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      characteristics: characteristics, // Agregado
    );
  }
}
