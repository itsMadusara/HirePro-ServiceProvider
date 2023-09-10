import 'dart:ffi';
import 'dart:io';

class SP {
  String id;
  String name;
  String email;
  String contact;
  // String nic;
  // File? image;
  // File? verifyImages;
  String points;
  String intro;
  List<String> category;

  SP({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    // required this.nic,
    // this.image,
    // required this.verifyImages,
    required this.points,
    required this.intro,
    required this.category,
  });

  factory SP.fromJson(Map<String, dynamic> json) {
    return SP(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      // nic: json['nic'],
      // verifyImages: json['verify_image'],
      points: json['points'],
      intro: json['intro'],
      category: (json['category'] as List).cast<String>(),
    );
  }
}