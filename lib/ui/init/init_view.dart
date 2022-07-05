import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/ui/nav/main_nav_view.dart';
import 'package:kcal_counter_flutter/ui/splash/splash_view.dart';
import 'package:kcal_counter_flutter/ui/terms/terms_view.dart';
import 'package:kcal_counter_flutter/ui/tools/general_ui.dart';
import 'package:kiwi/kiwi.dart';

import 'init_bloc.dart';

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

          if(state is TermsScreen) {
            return TermsViewPage();
          }

          if(state is InitStateMainNav) {
            return MainNavViewPage();
          }
          return GeneralUI.progressIndicator();
        },
        bloc: BlocProvider.of<InitBloc>(context));
  }
}
