import 'package:bloc/bloc.dart';
import 'package:calicut/service/api.dart';
import 'package:calicut/service/api.dart';
import 'package:calicut/model/model.dart';
import 'package:meta/meta.dart';

part 'percentagebloc_event.dart';
part 'percentagebloc_state.dart';

class PercentageblocBloc
    extends Bloc<PercentageblocEvent, PercentageblocState> {
  final API_Provider modal;

  PercentageblocBloc({required this.modal}) : super(PercentageblocInitial()) {
    // ignore: void_checks
    on<PercentageblocEvent>((event, emit) async {
      if (event is FetchData) {
        emit(PercentageLoadingState());
        try {
          print("Api calling");

          var data = await modal.getStudents();
          print("---------------");
          print(data);
          emit(PercentageLoadedState(data: data));
        } catch (e) {
          print(e.toString());
          emit(ErrorStae(error: e.toString()));
        }
      }
    });
  }
}
