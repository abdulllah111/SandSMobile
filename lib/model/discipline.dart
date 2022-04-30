
class Discipline {
  Discipline({
    required this.iddiscipline,
    required this.disciplineName,
  });

  int iddiscipline;
  String disciplineName;

  factory Discipline.fromJson(Map<String, dynamic> json) => Discipline(
    iddiscipline: json["iddiscipline"],
    disciplineName: json["discipline_name"],
  );

  Map<String, dynamic> toJson() => {
    "iddiscipline": iddiscipline,
    "discipline_name": disciplineName,
  };
}
