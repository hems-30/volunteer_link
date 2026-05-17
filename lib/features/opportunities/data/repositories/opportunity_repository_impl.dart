import '../../domain/entities/opportunity.dart';
import '../../domain/repositories/opportunity_repository.dart';
import '../datasources/opportunity_remote_data_source.dart';
import '../models/opportunity_model.dart';

class OpportunityRepositoryImpl implements OpportunityRepository {
  final OpportunityRemoteDataSource remoteDataSource;

  OpportunityRepositoryImpl({
    required this.remoteDataSource,
  });

  // ================= GET ALL =================
  @override
  Future<List<Opportunity>> getOpportunities() async {
    final result = await remoteDataSource.getOpportunities();
    return result;
  }

  // ================= GET BY ID =================
  @override
  Future<Opportunity> getOpportunityById(String id) async {
    final result = await remoteDataSource.getOpportunityById(id);
    return result;
  }

  // ================= CREATE =================
  @override
  Future<Opportunity> createOpportunity(Opportunity opportunity) async {
    final model = OpportunityModel(
      title: opportunity.title,
      organization: opportunity.organization,
      location: opportunity.location,
      category: opportunity.category,
      description: opportunity.description,
      date: opportunity.date,
    );

    final result =
        await remoteDataSource.createOpportunity(model);

    return result;
  }

  // ================= UPDATE =================
  @override
  Future<Opportunity> updateOpportunity(Opportunity opportunity) async {
    final model = OpportunityModel(
      id: opportunity.id,
      title: opportunity.title,
      organization: opportunity.organization,
      location: opportunity.location,
      category: opportunity.category,
      description: opportunity.description,
      date: opportunity.date,
    );

    final result =
        await remoteDataSource.updateOpportunity(model);

    return result;
  }

  // ================= DELETE =================
  @override
  Future<void> deleteOpportunity(String id) async {
    await remoteDataSource.deleteOpportunity(id);
  }
}