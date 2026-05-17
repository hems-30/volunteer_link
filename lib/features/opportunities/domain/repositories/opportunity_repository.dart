import '../entities/opportunity.dart';

abstract class OpportunityRepository {
  
  Future<List<Opportunity>> getOpportunities();

  Future<Opportunity> getOpportunityById(String id);

  Future<Opportunity> createOpportunity(Opportunity opportunity);

  Future<Opportunity> updateOpportunity(Opportunity opportunity);

  Future<void> deleteOpportunity(String id);
}