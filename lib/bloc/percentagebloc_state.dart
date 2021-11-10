part of 'percentagebloc_bloc.dart';

abstract class PercentageblocState {}

class PercentageblocInitial extends PercentageblocState {}

class PercentageLoadingState extends PercentageblocState {}

class PercentageLoadedState extends PercentageblocState {
  List<Modal> data;
  PercentageLoadedState({required this.data});
}

class ErrorStae extends PercentageblocState {
  var error;
  ErrorStae({required this.error});
}
