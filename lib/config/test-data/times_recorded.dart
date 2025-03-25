enum Penalty {
  noPenalty,
  plusTwo,
  dnf,
}

class Time {
  final String minutes;
  final String seconds;
  final String milliseconds;
  final String time;

  Time({
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
  }) : time = '$minutes:$seconds.$milliseconds';
}

class Date {
  final String day;
  final String month;
  final String year;
  final String date;

  Date({
    required this.day,
    required this.month,
    required this.year,
  }) : date = '$day/$month';
}

class TimerRecorded {
  final String id;
  final String comment;
  final Time time;
  final Date date;
  final String category;
  final String scramble;
  final String type;
  final Penalty penalty;

  TimerRecorded({
    required this.id,
    required this.time,
    required this.date,
    required this.category,
    required this.type,
    required this.scramble,
    required this.penalty,
    this.comment = "",
  });

  TimerRecorded copyWith({
    String? id,
    String? comment,
    Time? time,
    Date? date,
    String? category,
    String? scramble,
    String? type,
    Penalty? penalty,
  }) {
    return TimerRecorded(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      time: time ?? this.time,
      date: date ?? this.date,
      category: category ?? this.category,
      scramble: scramble ?? this.scramble,
      type: type ?? this.type,
      penalty: penalty ?? this.penalty,
    );
  }
}

final List<TimerRecorded> _timesRecorded = [
  TimerRecorded(
    id: '1',
    time: Time(minutes: '0', seconds: '18', milliseconds: '45'),
    date: Date(day: '01', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "R U R' U R U2 R'",
    penalty: Penalty.noPenalty,
  ),
  TimerRecorded(
    id: '2',
    time: Time(minutes: '0', seconds: '22', milliseconds: '19'),
    date: Date(day: '02', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "F2 U' L R2 D2 F' U2 L2 D2 R' B2",
    penalty: Penalty.plusTwo,
  ),
  TimerRecorded(
    id: '3',
    time: Time(minutes: '0', seconds: '16', milliseconds: '87'),
    date: Date(day: '03', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "R U R' U R U2 R' F R U R' U' F'",
    penalty: Penalty.dnf,
  ),
  TimerRecorded(
    id: '4',
    time: Time(minutes: '0', seconds: '21', milliseconds: '05'),
    date: Date(day: '04', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "L U2 L' U2 L B L' U' L U L B' L2",
    penalty: Penalty.noPenalty,
  ),
  TimerRecorded(
    id: '5',
    time: Time(minutes: '0', seconds: '20', milliseconds: '33'),
    date: Date(day: '05', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "U R U2 R' U' R U' R' L F' L' F",
    penalty: Penalty.noPenalty,
  ),
];
