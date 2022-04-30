class Office {
  Office({
    required this.idoffice,
    required this.officeNumber,
  });

  int idoffice;
  String officeNumber;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    idoffice: json["idoffice"],
    officeNumber: json["office_number"],
  );

  Map<String, dynamic> toJson() => {
    "idoffice": idoffice,
    "office_number": officeNumber,
  };
}