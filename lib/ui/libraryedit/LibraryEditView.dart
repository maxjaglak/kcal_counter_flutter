import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/core/library/dao/LibraryEntryDao.dart';
import 'package:kcal_counter_flutter/core/library/model/LibraryEntry.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/LibraryEditCubit.dart';
import 'package:kcal_counter_flutter/ui/tools/FormFieldHelper.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';
import 'package:kcal_counter_flutter/ui/tools/TextHelper.dart';

class LibraryEditViewPage extends StatelessWidget {
  final LibraryEntry? libraryEntry;

  const LibraryEditViewPage({Key? key, this.libraryEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libraryEntry == null ? "Dodaj" : "Edytuj"),
      ),
      body: LibraryEditViewCubit(
          libraryEntry: libraryEntry,
          key: libraryEntry == null ? UniqueKey() : ObjectKey(libraryEntry!)),
    );
  }
}

class LibraryEditViewCubit extends StatelessWidget {
  final LibraryEntry? libraryEntry;

  final cubit =
      KiwiInjector.instance.getContainer().resolve<LibraryEditCubit>();

  LibraryEditViewCubit({Key? key, this.libraryEntry}) : super(key: key) {
    cubit.init(this.libraryEntry);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => cubit, child: LibraryEditView());
  }
}

class LibraryEditView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LibraryEditViewState();
}

class LibraryEditViewState extends State<LibraryEditView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _perUnitCountController = TextEditingController();
  final TextEditingController _kcalsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();

  final Set<TextEditingController> _failingControllers = HashSet();

  late ValidationCallback _validationCallback;

  @override
  void initState() {
    super.initState();
    _validationCallback = (controller, isValid) {
      if (isValid)
        _failingControllers.remove(controller);
      else
        _failingControllers.add(controller);
    };

    _unitNameController.text = "g";
    _perUnitCountController.text = "100";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<LibraryEditCubit, LibraryEditState>(
          builder: (context, state) {
            if (state.loading || state.libraryEntry == null)
              return GeneralUI.progressIndicator();

            return _body(context, state.libraryEntry!);
          },
          bloc: BlocProvider.of<LibraryEditCubit>(context)),
    );
  }

  Widget _body(BuildContext context, LibraryEntry libraryEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHelper.titleText(
            libraryEntry.id == null ? "Dodaj nowy wpis" : "Edytuj"),
        FormFieldHelper.textField(_nameController,
            autoCorrect: true,
            validator: (value) => value?.isNotEmpty != true
                ? "Pole nazwa nie może być puste"
                : null,
            validationCallback: _validationCallback),
        TextHelper.label("Nazwa"),
        FormFieldHelper.textField(_unitNameController,
            autoCorrect: false,
            validator: (value) =>
                value?.isNotEmpty != true ? "Pole nie może być puste" : null,
            validationCallback: _validationCallback),
        TextHelper.label("Nazwa jednostki"),
        FormFieldHelper.textField(_perUnitCountController,
            autoCorrect: false,
            textInputType: TextInputType.number,
            validator: (value) => value != null &&
                    (int.tryParse(value) ?? 0) > 0
                ? null
                : "Pole ilość jednostek w porcji musi zawierać liczbę dodatnią",
            validationCallback: _validationCallback),
        TextHelper.label("Ile jednostek w porcji (np. 100g)"),
        FormFieldHelper.textField(_kcalsController,
            autoCorrect: false,
            textInputType: TextInputType.number,
            validator: (value) =>
                value != null && (int.tryParse(value) ?? 0) > 0
                    ? null
                    : "Pole kalorie w porcji musi zawierać liczbę dodatnią",
            validationCallback: _validationCallback),
        TextHelper.label("Kcale w porcji"),
        FormFieldHelper.textField(_carbsController,
            autoCorrect: false,
            textInputType: TextInputType.number,
            validator: (value) =>
                value != null && (double.tryParse(value) ?? 0) >= 0
                    ? null
                    : "Pole węgle w porcji musi zawierać liczbę >= 0",
            validationCallback: _validationCallback),
        TextHelper.label("Węgle w porcji"),
        FormFieldHelper.textField(_fatsController,
            autoCorrect: false,
            textInputType: TextInputType.number,
            validator: (value) =>
                value != null && (double.tryParse(value) ?? 0) >= 0
                    ? null
                    : "Pole tłuszcze w porcji musi zawierać liczbę >= 0",
            validationCallback: _validationCallback),
        TextHelper.label("Tłuszcze w porcji"),
        FormFieldHelper.textField(_proteinController,
            autoCorrect: false,
            textInputType: TextInputType.number,
            validator: (value) =>
                value != null && (double.tryParse(value) ?? 0) >= 0
                    ? null
                    : "Pole białko w porcji musi zawierać liczbę >= 0",
            validationCallback: _validationCallback),
        TextHelper.label("Białko w porcji"),
        TextButton(
            onPressed: () => _save(context, libraryEntry),
            child: Text("Zapisz"))
      ],
    );
  }

  _save(BuildContext context, LibraryEntry libraryEntry) async {
    if (_failingControllers.isNotEmpty) return;

    libraryEntry.name = _nameController.text.toString();
    libraryEntry.unitName = _unitNameController.text.toString();
    libraryEntry.perUnitCount =
        int.tryParse(_perUnitCountController.text.toString()) ??
            libraryEntry.perUnitCount;
    libraryEntry.kcals =
        int.tryParse(_kcalsController.text.toString()) ?? libraryEntry.kcals;
    libraryEntry.carbs =
        double.tryParse(_carbsController.text.toString()) ?? libraryEntry.carbs;
    libraryEntry.fat =
        double.tryParse(_fatsController.text.toString()) ?? libraryEntry.fat;
    libraryEntry.protein =
        double.tryParse(_proteinController.text.toString()) ??
            libraryEntry.protein;

    await BlocProvider.of<LibraryEditCubit>(context).save(libraryEntry);

    Navigator.of(context).pop();
  }
}
