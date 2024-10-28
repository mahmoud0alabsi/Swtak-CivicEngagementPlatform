part of 'ongoing_round_bloc.dart';

abstract class OngoingRoundState {}

final class OngoingRoundInitial extends OngoingRoundState {}

final class OngoingRoundLoading extends OngoingRoundState {}

final class OngoingRoundLoaded extends OngoingRoundState {}

final class OngoingRoundError extends OngoingRoundState {
  final String message;

  OngoingRoundError(this.message);
}
