import '../../domain/entities/opportunity.dart';

abstract class OpportunityEvent {}

class LoadOpportunities extends OpportunityEvent {}

class GetOpportunityById extends OpportunityEvent {
  final String id;
  GetOpportunityById(this.id);
}

class CreateOpportunity extends OpportunityEvent {
  final Opportunity opportunity;
  CreateOpportunity(this.opportunity);
}

class UpdateOpportunity extends OpportunityEvent {
  final Opportunity opportunity;
  UpdateOpportunity(this.opportunity);
}

class DeleteOpportunity extends OpportunityEvent {
  final String id;
  DeleteOpportunity(this.id);
}