class Mentoria {
  final String categoryKey;
  final String title;
  final String description;
  final String detail; 
  final List<Characteristic> characteristics; 

  Mentoria({
    required this.categoryKey,
    required this.title,
    required this.description,
    required this.detail,
    required this.characteristics,
  });

  factory Mentoria.fromJson(Map<String, dynamic> json) {
    var characteristicList = json['characteristics'] as List;
    List<Characteristic> characteristics =
        characteristicList.map((i) => Characteristic.fromJson(i)).toList();

    return Mentoria(
      categoryKey: json['categoryKey'] ?? '',
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      detail: json['detail'] ?? '',
      characteristics: characteristics,
    );
  }
}

class Characteristic {
  final String description; 
  final String icon; 
  final bool isActive;

  Characteristic({
    required this.description,
    required this.icon,
    required this.isActive,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }
}