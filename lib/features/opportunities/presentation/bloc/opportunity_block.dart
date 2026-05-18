import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/opportunity_repository.dart';
import 'opportunity_event.dart';
import 'opportunity_state.dart';

class OpportunityBloc extends Bloc<OpportunityEvent, OpportunityState> {
  final OpportunityRepository repository;

  OpportunityBloc({required this.repository})
      : super(OpportunityInitial()) {
    
    // ================= LOAD ALL =================
    on<LoadOpportunities>((event, emit) async {
      emit(OpportunityLoading());
      try {
        final data = await repository.getOpportunities();
        emit(OpportunityLoaded(data));
      } catch (e) {
        emit(OpportunityError("Failed to load opportunities"));
      }
    });

    // ================= GET BY ID =================
    on<GetOpportunityById>((event, emit) async {
      emit(OpportunityLoading());
      try {
        final data =
            await repository.getOpportunityById(event.id);
        emit(OpportunitySingleLoaded(data));
      } catch (e) {
        emit(OpportunityError("Failed to load opportunity"));
      }
    });

    // ================= CREATE =================
    on<CreateOpportunity>((event, emit) async {
      emit(OpportunityLoading());
      try {
        await repository.createOpportunity(event.opportunity);
        emit(OpportunitySuccess("Created successfully"));
      } catch (e) {
        emit(OpportunityError("Failed to create opportunity"));
      }
    });

    // ================= UPDATE =================
    on<UpdateOpportunity>((event, emit) async {
      emit(OpportunityLoading());
      try {
        await repository.updateOpportunity(event.opportunity);
        emit(OpportunitySuccess("Updated successfully"));
      } catch (e) {
        emit(OpportunityError("Failed to update opportunity"));
      }
    });

    // ================= DELETE =================
    on<DeleteOpportunity>((event, emit) async {
      emit(OpportunityLoading());
      try {
        await repository.deleteOpportunity(event.id);
        emit(OpportunitySuccess("Deleted successfully"));
      } catch (e) {
        emit(OpportunityError("Failed to delete opportunity"));
      }
    });
  }
}