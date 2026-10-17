import 'package:equatable/equatable.dart';

class SplashModel extends Equatable {

  final String name;

  const SplashModel({required this.name});

  factory SplashModel.fromJson(Map<String, dynamic> json) => SplashModel(name: json['name']);



  @override
  List<Object> get props => [name];
}