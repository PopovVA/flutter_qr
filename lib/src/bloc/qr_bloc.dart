import 'package:bloc/bloc.dart';
import '../pages/camera.dart';
import 'qr_event.dart';
import 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  @override
  QrState get initialState => AppUninitialized();

  @override
  Stream<QrState> mapEventToState(QrEvent event) async* {
    if (event is ShowCamera) {
      try {
        final String data = await scan();
        yield DataLoading();
        yield DataLoaded(data);
      } catch (error) {
        yield DataLoadingError(error.toString());
      }
    }
  }
}
