class Visitor {
  final String name;
  final String location;
  final String image; // network URL or local asset path
  bool isCompleted;

  Visitor({
    required this.name,
    required this.location,
    required this.image,
    this.isCompleted = false,
  });
}