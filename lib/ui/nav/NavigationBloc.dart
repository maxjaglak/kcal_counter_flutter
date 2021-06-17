import 'package:bloc/bloc.dart';

class NavigationBloc extends Bloc<NavEvent, NavState> {

  NavigationBloc() : super(NavState(0));

  @override
  Stream<NavState> mapEventToState(NavEvent event) async* {
    yield NavState(event.selectedView);
  }

}

class NavEvent {
  final int selectedView;

  NavEvent(this.selectedView);

}

class NavState {
  final int selectedView;

  NavState(this.selectedView);
}