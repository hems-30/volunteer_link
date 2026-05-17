import '../entities/opportunity.dart';

abstract class OpportunityRepository {
  // READ all
  Future<List<Opportunity>> getOpportunities();

  // READ single
  Future<Opportunity> getOpportunityById(String id);

  // CREATE
  Future<Opportunity> createOpportunity(Opportunity opportunity);

  // UPDATE
  Future<Opportunity> updateOpportunity(Opportunity opportunity);

  // DELETE
  Future<void> deleteOpportunity(String id);
}