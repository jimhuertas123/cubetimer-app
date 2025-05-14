class TimeRecordRepository {
    final int id;
    final int categoryId;
    final double time;
    final String scramble;
    final String date;

    TimeRecordRepository({
        required this.id, 
        required this.categoryId,
        required this.time,
        required this.scramble,
        required this.date
    });

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'categoryId': categoryId,
            'time': time,
            'scramble': scramble,
            'date': date,
        };
    }

    factory TimeRecordRepository.fromMap(Map<String, dynamic> map) {
        return TimeRecordRepository(
            id: map['id'],
            categoryId: map['categoryId'],
            time: map['time'],
            scramble: map['scramble'],
            date: map['date'],
        );
    }

}
