class TimeRecordModel {
  final int id;
  final int categoryId;
  final double time;
  final String scramble;
  final String date;
  final String? comment;

  TimeRecordModel({
    required this.id,
    required this.categoryId,
    required this.time,
    required this.scramble,
    required this.date,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'time': time,
      'scramble': scramble,
      'date': date,
      'comment': comment,
    };
  }

  factory TimeRecordModel.fromMap(Map<String, dynamic> map) {
    return TimeRecordModel(
      id: map['id'],
      categoryId: map['categoryId'],
      time: map['time'],
      scramble: map['scramble'],
      date: map['date'],
      comment: map['comment'],
    );
  }
}
