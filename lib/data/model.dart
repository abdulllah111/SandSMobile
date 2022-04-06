class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/icon/home.png', name: 'ПН'),
  Model(id: 1, imagePath: 'assets/icon/search.png', name: 'ВТ'),
  Model(id: 2, imagePath: 'assets/icon/heart.png', name: 'СР'),
  Model(id: 3, imagePath: 'assets/icon/notification.png', name: 'ЧТ'),
  Model(id: 4, imagePath: 'assets/icon/user.png', name: 'ПТ'),
  Model(id: 5, imagePath: 'assets/icon/user.png', name: 'СБ'),
];
