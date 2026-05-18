import '../../domain/entities/opportunity.dart';

abstract class OpportunityState {}

class OpportunityInitial extends OpportunityState {}

class OpportunityLoading extends OpportunityState {}

class OpportunityLoaded extends OpportunityState {
  final List<Opportunity> opportunities;

  OpportunityLoaded(this.opportunities);
}

class OpportunitySingleLoaded extends OpportunityState {
  final Opportunity opportunity;

  OpportunitySingleLoaded(this.opportunity);
}

class OpportunitySuccess extends OpportunityState {
  final String message;

  OpportunitySuccess(this.message);
}

class OpportunityError extends OpportunityState {
  final String message;

  OpportunityError(this.message);
}