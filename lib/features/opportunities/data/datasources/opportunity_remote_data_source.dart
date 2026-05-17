import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/opportunity_model.dart';

class OpportunityRemoteDataSource {
  final DioClient dioClient;

  OpportunityRemoteDataSource({required this.dioClient});

  // ================= GET ALL =================
  Future<List<OpportunityModel>> getOpportunities() async {
    final response = await dioClient.get(ApiEndpoints.opportunities);

    final List data = response.data;

    return data
        .map((json) => OpportunityModel.fromJson(json))
        .toList();
  }

  // ================= GET BY ID =================
  Future<OpportunityModel> getOpportunityById(String id) async {
    final response =
        await dioClient.get(ApiEndpoints.opportunityById(id));

    return OpportunityModel.fromJson(response.data);
  }

  // ================= CREATE =================
  Future<OpportunityModel> createOpportunity(
    OpportunityModel opportunity,
  ) async {
    final response = await dioClient.post(
      ApiEndpoints.opportunities,
      data: opportunity.toJson(),
    );

    return OpportunityModel.fromJson(response.data);
  }

  // ================= UPDATE =================
  Future<OpportunityModel> updateOpportunity(
    OpportunityModel opportunity,
  ) async {
    final response = await dioClient.put(
      ApiEndpoints.opportunityById(opportunity.id!),
      data: opportunity.toJson(),
    );

    return OpportunityModel.fromJson(response.data);
  }

  // ================= DELETE =================
  Future<void> deleteOpportunity(String id) async {
    await dioClient.delete(
      ApiEndpoints.opportunityById(id),
    );
  }
}