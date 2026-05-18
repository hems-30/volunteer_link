import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/opportunity_model.dart';

class OpportunityRemoteDataSource {
  final DioClient dioClient;

  OpportunityRemoteDataSource({required this.dioClient});

  
  Future<List<OpportunityModel>> getOpportunities() async {
    final response = await dioClient.get(ApiEndpoints.opportunities);

    final List data = response.data as List;

    return data
        .map((json) => OpportunityModel.fromJson(json))
        .toList();
  }

 
  Future<OpportunityModel> getOpportunityById(String id) async {
    final response =
        await dioClient.get(ApiEndpoints.opportunityById(id));

    return OpportunityModel.fromJson(response.data);
  }

 
  Future<OpportunityModel> createOpportunity(
    OpportunityModel opportunity,
  ) async {
    final response = await dioClient.post(
      ApiEndpoints.opportunities,
      data: opportunity.toJson(),
    );

    return OpportunityModel.fromJson(response.data);
  }

 
  Future<OpportunityModel> updateOpportunity(
    OpportunityModel opportunity,
  ) async {
    final response = await dioClient.put(
      ApiEndpoints.opportunityById(opportunity.id!),
      data: opportunity.toJson(),
    );

    return OpportunityModel.fromJson(response.data);
  }

  
  Future<void> deleteOpportunity(String id) async {
    await dioClient.delete(
      ApiEndpoints.opportunityById(id),
    );
  }
}