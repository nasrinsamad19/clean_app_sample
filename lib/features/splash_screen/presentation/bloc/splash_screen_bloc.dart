import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    // ignore: void_checks
    on<SplashScreenEvent>((event, emit) async* {
      // TODO: implement event handler
      if (event is SetSplash) {
        yield Loading();
        //todo: add some actions like checking the connection etc.
        //I simulate the process with future delayed for 3 second
        await Future.delayed(Duration(seconds: 3));
        yield Loaded();
      }
    });
  }

  @override
  SplashScreenState get initialState => SplashScreenInitial();

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is SetSplash) {
      yield Loading();
      //todo: add some actions like checking the connection etc.
      //I simulate the process with future delayed for 3 second
      await Future.delayed(Duration(seconds: 3));
      yield Loaded();
    }
  }
}
