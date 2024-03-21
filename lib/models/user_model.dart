// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? gender;
  final String address;
  final int age;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    this.gender,
    required this.age
  });

  static const empty = UserModel(id: '', email: '', name: '', phone: '', address: '',age: 0);

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? address,
    String? gender,
    int? age
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name, 
      phone: phone ?? this.phone,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      age: age ?? this.age
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'gender' : gender,
      'age' : age

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, email, name, phone, address, gender!];
}
