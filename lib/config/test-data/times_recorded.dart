enum Penalty {
  noPenalty,
  plusTwo,
  dnf,
}

class Time{

  final String hours;
  final String minutes;
  final String time;

  Time({
    required this.hours,
    required this.minutes,
  }) : time = '$hours:$minutes';
}

class SolveTime {
  final String minutes;
  final String seconds;
  final String milliseconds;
  final String time;

  SolveTime({
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
  final SolveTime solveTime;
  final Time recordedTime;
  final Date recordedDate;
  final String category;
  final String scramble;
  final String type;
  final Penalty penalty;

  TimerRecorded({
    required this.solveTime, 
    required this.recordedTime, 
    required this.recordedDate, 
    required this.id,
    required this.category,
    required this.type,
    required this.scramble,
    required this.penalty,
    this.comment = "",
  });

  TimerRecorded copyWith({
    String? id,
    String? comment,
    SolveTime? solveTime,
    Time? recordedTime,
    Date? recordedDate,
    String? category,
    String? scramble,
    String? type,
    Penalty? penalty,
  }) {
    return TimerRecorded(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      recordedTime: recordedTime ?? this.recordedTime,
      recordedDate: recordedDate ?? this.recordedDate,
      solveTime: solveTime ?? this.solveTime,
      category: category ?? this.category,
      scramble: scramble ?? this.scramble,
      type: type ?? this.type,
      penalty: penalty ?? this.penalty,
    );
  }
}

final List<TimerRecorded> timesRecorded = [
  TimerRecorded(
    id: '1',
    solveTime: SolveTime(minutes: '0', seconds: '18', milliseconds: '45'),
    recordedTime: Time(hours: '10', minutes: '18'),
    recordedDate: Date(day: '01', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "R U R' U R U2 R'",
    comment: "First solve of the day",
    penalty: Penalty.noPenalty,
  ),
  TimerRecorded(
    id: '2',
    solveTime: SolveTime(minutes: '0', seconds: '22', milliseconds: '19'),
    recordedTime: Time(hours: '01', minutes: '22'),
    recordedDate: Date(day: '02', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "F2 U' L R2 D2 F' U2 L2 D2 R' B2",
    penalty: Penalty.plusTwo
  ),
  TimerRecorded(
    id: '3',
    solveTime: SolveTime(minutes: '0', seconds: '16', milliseconds: '87'),
    recordedTime: Time(hours: '08', minutes: '16'),
    recordedDate: Date(day: '03', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "R U R' U R U2 R' F R U R' U' F'",
    penalty: Penalty.dnf
  ),
  TimerRecorded(
    id: '4',
    solveTime: SolveTime(minutes: '0', seconds: '21', milliseconds: '05'),
    recordedTime: Time(hours: '16', minutes: '21'),
    recordedDate: Date(day: '04', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "L U2 L' U2 L B L' U' L U L B' L2",
    penalty: Penalty.noPenalty
  ),
  TimerRecorded(
    id: '5',
    solveTime: SolveTime(minutes: '0', seconds: '20', milliseconds: '33'),
    recordedTime: Time(hours: '02', minutes: '20'),
    recordedDate: Date(day: '05', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "U R U2 R' U' R U' R' L F' L' F",
    penalty: Penalty.noPenalty
  ),
  TimerRecorded(
    id: '6',
    solveTime: SolveTime(minutes: '0', seconds: '19', milliseconds: '12'),
    recordedTime: Time(hours: '22', minutes: '19'),
    recordedDate: Date(day: '06', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "R U R' U R U2 R' F R U R' U' F'",
    penalty: Penalty.noPenalty
  ),
  TimerRecorded(
    id: '7',
    solveTime: SolveTime(minutes: '1', seconds: '23', milliseconds: '45'),
    recordedTime: Time(hours: '00', minutes: '23'),
    recordedDate: Date(day: '07', month: '03', year: '2025'),
    category: '3x3x3',
    type: 'normal',
    scramble: "F R U R' U' F'",
    penalty: Penalty.noPenalty
  ),
];
