import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:cube_timer_2/config/test-data/times_recorded.dart';

class CategoryModel {
  final int? id;
  final String name;
  final int cubeTypeId;
  // for analyze data of timesRecorded purpose (all calculated in secods,
  // but show in minutes, seconds and milliseconds MM:SS.SSS)
  final int? shortestTime;
  final int? longestTime;
  final int? ao100;
  final int? ao50;
  final int? ao12;
  final int? ao5;
  final int? mean;
  final int? deviation;
  final int? sum50;
  final int? sum100;
  final int? sum12;
  final int? sum5;
  final int? sum;
  final int? count;

  CategoryModel({
    this.id,
    required this.name,
    required this.cubeTypeId,
    this.shortestTime,
    this.longestTime,
    this.ao100,
    this.ao50,
    this.ao12,
    this.ao5,
    this.mean,
    this.deviation,
    this.sum,
    this.sum5,
    this.sum12,
    this.sum50,
    this.sum100,
    this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cubeTypeId': cubeTypeId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      cubeTypeId: map['cubeTypeId'],
      shortestTime: map['shortestTime'],
      ao100: map['ao100'],
      ao50: map['ao50'],
      ao12: map['ao12'],
      ao5: map['ao5'],
      mean: map['mean'],
      deviation: map['deviation'],
      sum: map['sum'],
      count: map['count'],
      sum5: map['sum5'],
      sum12: map['sum12'],
      sum50: map['sum50'],
      sum100: map['sum100'],
    );
  }

  CategoryModel copyWith({
  int? id,
  String? name,
  int? cubeTypeId,
  int? shortestTime,
  int? longestTime,
  int? ao100,
  int? ao50,
  int? ao12,
  int? ao5,
  int? mean,
  int? deviation,
  int? sum,
  int? sum5,
  int? sum12,
  int? sum50,
  int? sum100,
  int? count,
}) {
  return CategoryModel(
    id: id ?? this.id,
    name: name ?? this.name,
    cubeTypeId: cubeTypeId ?? this.cubeTypeId,
    shortestTime: shortestTime ?? this.shortestTime,
    longestTime: longestTime ?? this.longestTime,
    ao100: ao100 ?? this.ao100,
    ao50: ao50 ?? this.ao50,
    ao12: ao12 ?? this.ao12,
    ao5: ao5 ?? this.ao5,
    mean: mean ?? this.mean,
    deviation: deviation ?? this.deviation,
    sum: sum ?? this.sum,
    sum5: sum5 ?? this.sum5,
    sum12: sum12 ?? this.sum12,
    sum50: sum50 ?? this.sum50,
    sum100: sum100 ?? this.sum100,
    count: count ?? this.count,
  );
  }
}
