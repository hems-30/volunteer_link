import '../../domain/entities/opportunity.dart';

class OpportunityModel extends Opportunity {
  OpportunityModel({
    String? id,
    required String title,
    required String organization,
    required String location,
    required String category,
    required String description,
    required String date,
  }) : super(
          id: id,
          title: title,
          organization: organization,
          location: location,
          category: category,
          description: description,
          date: date,
        );

  // ================= FROM JSON =================
  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    return OpportunityModel(
      id: json['id'],
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
    );
  }

  // ================= TO JSON =================
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'organization': organization,
      'location': location,
      'category': category,
      'description': description,
      'date': date,
    };
  }

  // ================= COPY WITH =================
  OpportunityModel copyWith({
    String? id,
    String? title,
    String? organization,
    String? location,
    String? category,
    String? description,
    String? date,
  }) {
    return OpportunityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      organization: organization ?? this.organization,
      location: location ?? this.location,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}