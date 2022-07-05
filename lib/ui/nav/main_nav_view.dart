import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/ui/history/history_view.dart';
import 'package:kcal_counter_flutter/ui/library/library_view_tab.dart';
import 'package:kcal_counter_flutter/ui/nav/navigation_bloc.dart';
import 'package:kcal_counter_flutter/ui/settingstab/settings_tab_view.dart';
import 'package:kcal_counter_flutter/ui/todaytab/today_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainNavViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
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
  List<Widget> _views = <Widget>[
    TodayTabViewBloc(),
    HistoryViewCubit(),
    LibraryViewTab(),
    SettingsTabViewCubit()
  ];

  List<BottomNavigationBarItem>? _navItems;

  @override
  Widget build(BuildContext context) {
    if (_navItems == null) {
      _fillNavItems(context);
    }
    return BlocBuilder<NavigationBloc, NavState>(
        builder: (context, state) => Scaffold(
            body: _views[state.selectedView],
            bottomNavigationBar: BottomNavigationBar(
                items: _navItems!,
                currentIndex: state.selectedView,
                selectedItemColor: Color.fromARGB(255, 57, 214, 138),
                unselectedItemColor: Colors.grey,
                onTap: (index) => BlocProvider.of<NavigationBloc>(context)
                    .add(NavEvent(index)))));
  }

  void _fillNavItems(BuildContext context) {
    _navItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: AppLocalizations.of(context)!.navTabToday),
      BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: AppLocalizations.of(context)!.navTabHistory),
      BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: AppLocalizations.of(context)!.navTabLibrary),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.navTabSettings)
    ];
  }
}
