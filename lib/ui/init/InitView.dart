import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/ui/nav/MainNavView.dart';
import 'package:kcal_counter_flutter/ui/splash/SplashView.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';
import 'package:kiwi/kiwi.dart';

import 'InitBloc.dart';

class InitViewBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => InitBloc(), child: InitView());
  }
}

class InitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitBloc, InitState>(
        builder: (context, state) {
          if(state is InitStateSplash) {
            return SplashViewScreen();
          }
          if(state is InitStateMainNav) {
            return MainNavViewPage();
          }
          return GeneralUI.progressIndicator();
        },
        bloc: BlocProvider.of<InitBloc>(context));
  }
}
