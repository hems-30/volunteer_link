class Opportunity {
  final String? id;
  final String title;
  final String organization;
  final String location;
  final String category;
  final String description;
  final String date;

  Opportunity({
    this.id,
    required this.title,
    required this.organization,
    required this.location,
    required this.category,
    required this.description,
    required this.date,
  });
}