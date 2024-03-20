// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String phone;
  final String dob;
  final String? gender;
  final String address;

  const UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.dob,
    required this.address,
    this.gender
  });

  static const empty = UserModel(userId: '', email: '', name: '', phone: '', dob: '', address: '');

  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    String? phone,
    String? dob,
    String? address,
    String? gender
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name, 
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'name': name,
      'phone': phone,
      'dob': dob,
      'address': address,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      dob: map['dob'] as String,
      address: map['address'] as String,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [userId, email, name, phone, dob, address, gender!];
}
