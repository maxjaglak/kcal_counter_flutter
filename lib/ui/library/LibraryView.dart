import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';

import 'LibraryBloc.dart';
import 'LibraryListView.dart';

class LibraryViewCubit extends StatelessWidget {
  final LibraryListListener? listener;

  const LibraryViewCubit({Key? key, this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            KiwiInjector.instance.getContainer().resolve<LibraryCubit>(),
        child: LibraryView(listener: listener));
  }
}

class LibraryView extends StatelessWidget {
  final LibraryListListener? listener;

  const LibraryView({Key? key, this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
        bloc: BlocProvider.of<LibraryCubit>(context),
        builder: (context, state) {
          if (state.loading) {
            return GeneralUI.progressIndicator();
          } else if (state.entries?.isNotEmpty == true) {
            return LibraryListView(
              entries: state.entries!,
              key: ObjectKey(state.entries),
              listener: listener,
            );
          } else {
            return Text("list empty");
          }
        });
  }
}
