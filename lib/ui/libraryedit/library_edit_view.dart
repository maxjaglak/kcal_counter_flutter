import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/core/library/dao/library_entry_dao.dart';
import 'package:kcal_counter_flutter/core/library/model/library_entry.dart';
import 'package:kcal_counter_flutter/ui/libraryedit/library_edit_cubit.dart';
import 'package:kcal_counter_flutter/ui/tools/form_field_helper.dart';
import 'package:kcal_counter_flutter/ui/tools/general_ui.dart';
import 'package:kcal_counter_flutter/ui/tools/text_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibraryEditViewPage extends StatelessWidget {
  final LibraryEntry? libraryEntry;

  const LibraryEditViewPage({Key? key, this.libraryEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libraryEntry == null ? AppLocalizations.of(context)!.editAddNewEntry : AppLocalizations.of(context)!.editEdit),
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

  bool _isFavourite = false;
  bool _isDateFilledOnLoad = false;

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
    if (libraryEntry.id != null && !_isDateFilledOnLoad) {
      _nameController.text = libraryEntry.name;
      _unitNameController.text = libraryEntry.unitName;
      _perUnitCountController.text = libraryEntry.perUnitCount.toString();
      _kcalsController.text = libraryEntry.kcals.toString();
      _carbsController.text = libraryEntry.carbs.toString();
      _fatsController.text = libraryEntry.fat.toString();
      _proteinController.text = libraryEntry.protein.toString();
      _isFavourite = libraryEntry.isFavourite;
      _isDateFilledOnLoad = true;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHelper.titleText(
              libraryEntry.id == null ? AppLocalizations.of(context)!.editAddNewEntry : AppLocalizations.of(context)!.editEdit),
          FormFieldHelper.textField(_nameController,
              autoCorrect: true,
              textInputAction: TextInputAction.next,
              validator: (value) => value?.isNotEmpty != true
                  ? AppLocalizations.of(context)!.editValidationNameCannotBeEmpty
                  : null,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelName),
          FormFieldHelper.textField(_unitNameController,
              autoCorrect: false,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  value?.isNotEmpty != true ? AppLocalizations.of(context)!.editValidationFieldCannotBeEmpty : null,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelUnitName),
          FormFieldHelper.textField(_perUnitCountController,
              autoCorrect: false,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              validator: (value) => value != null &&
                      (int.tryParse(value) ?? 0) > 0
                  ? null
                  : AppLocalizations.of(context)!.editValidationUnitCountMustContainInteger,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelHowManyUnitsInEntry),
          FormFieldHelper.textField(_kcalsController,
              autoCorrect: false,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              validator: (value) =>
                  value != null && (int.tryParse(value) ?? 0) > 0
                      ? null
                      : AppLocalizations.of(context)!.editValidationKcalsMustContainInteger,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelKcalInEntry),
          FormFieldHelper.textField(_carbsController,
              autoCorrect: false,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value != null && (double.tryParse(value) ?? 0) >= 0
                      ? null
                      : AppLocalizations.of(context)!.editValidationCarbsCountMustContainInteger,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelCarbsInEntry),
          FormFieldHelper.textField(_fatsController,
              autoCorrect: false,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value != null && (double.tryParse(value) ?? 0) >= 0
                      ? null
                      : AppLocalizations.of(context)!.editValidationFatCountMustContainInteger,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelFatInEntry),
          FormFieldHelper.textField(_proteinController,
              autoCorrect: false,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value != null && (double.tryParse(value) ?? 0) >= 0
                      ? null
                      : AppLocalizations.of(context)!.editValidationProteinCountMustContainInteger,
              validationCallback: _validationCallback),
          TextHelper.label(AppLocalizations.of(context)!.editLabelProteinInEntry),
          Row(
            children: [
              Checkbox(
                  value: _isFavourite,
                  onChanged: (value) => _onFavouriteChanged(value ?? false)),
              Text(AppLocalizations.of(context)!.editLabelFavourite)
            ],
          ),
          TextButton(
              onPressed: () => _save(context, libraryEntry),
              child: Text(AppLocalizations.of(context)!.save))
        ],
      ),
    );
  }

  _onFavouriteChanged(bool value) {
    setState(() {
      _isFavourite = value;
    });
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
    libraryEntry.carbs = double.tryParse(
            _carbsController.text.toString().replaceAll(",", ".")) ??
        libraryEntry.carbs;
    libraryEntry.fat =
        double.tryParse(_fatsController.text.toString().replaceAll(",", ".")) ??
            libraryEntry.fat;
    libraryEntry.protein = double.tryParse(
            _proteinController.text.toString().replaceAll(",", ".")) ??
        libraryEntry.protein;
    libraryEntry.isFavourite = _isFavourite;

    await BlocProvider.of<LibraryEditCubit>(context).save(libraryEntry);

    Navigator.of(context).pop(libraryEntry);
  }
}
