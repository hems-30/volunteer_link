import '../utils/constants.dart';

class ApiEndpoints {
  static const String baseUrl = AppConstants.baseUrl;

  static const String opportunities = "/opportunities";

  static String opportunityById(String id) =>
      "/opportunities/$id";
}