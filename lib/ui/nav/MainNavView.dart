import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/daycount/DayView.dart';
import 'package:kcal_counter_flutter/ui/history/HistoryView.dart';
import 'package:kcal_counter_flutter/ui/library/LibraryView.dart';
import 'package:kcal_counter_flutter/ui/nav/NavigationBloc.dart';

class MainNavViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Licznik Kcal'ów"),
      ),
      body: MobileNavigationViewBloc(),
    );
  }
}

class MobileNavigationViewBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            KiwiInjector.instance.getContainer().resolve<NavigationBloc>(),
        child: MobileNavigationView());
  }
}

class MobileNavigationView extends StatelessWidget {
  List<Widget> _views = <Widget>[DayView(), HistoryView(), LibraryViewCubit()];

  List<BottomNavigationBarItem> _navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Dzisiaj"),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historia"),
    BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Tabela")
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavState>(
        builder: (context, state) => Scaffold(
            body: _views[state.selectedView],
            bottomNavigationBar: BottomNavigationBar(
                items: _navItems,
                currentIndex: state.selectedView,
                selectedItemColor: Colors.lightBlue,
                unselectedItemColor: Colors.grey,
                onTap: (index) => BlocProvider.of<NavigationBloc>(context)
                    .add(NavEvent(index)))));
  }
}
