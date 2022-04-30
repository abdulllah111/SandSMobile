class Weekday {
  Weekday({
    required this.idweekday,
    required this.weekdayName,
  });

  int idweekday;
  String weekdayName;

  factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
    idweekday: json["idweekday"],
    weekdayName: json["weekday_name"],
  );

  Map<String, dynamic> toJson() => {
    "idweekday": idweekday,
    "weekday_name": weekdayName,
    };
  }