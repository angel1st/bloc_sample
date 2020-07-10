import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample_app/utils/global_translations.dart';
import 'package:bloc_sample_app/presentation/blocs/bloc.dart';
import 'package:moor/moor.dart';

class NameWidget extends StatefulWidget {
  final String name;
  const NameWidget({@required this.name});
  @override
  _NameWidgetState createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  TextEditingController _nameFieldController;
  Timer _debounce;

  @override
  void initState() {
    super.initState();

    _nameFieldController = TextEditingController();
    _nameFieldController.addListener(_inputName);
    _nameFieldController.text = widget.name;
  }

  @override
  void dispose() {
    _nameFieldController.removeListener(_inputName);
    _nameFieldController?.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void _inputName() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<PlantBloc>(context).add(
        PlantEventNewName(name: _nameFieldController.text),
      );
    });
  }

  bool _isValid() {
    final Value<String> name =
        BlocProvider.of<PlantBloc>(context).state.plantsCompanion.name;
    return name.present && name.value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BlocBuilder<PlantBloc, PlantState>(
          condition: (PlantState prev, PlantState curr) {
            return curr is PlantStateNameSet;
          },
          builder: (BuildContext context, PlantState state) => TextField(
                enabled: true,
                // below line will ensure, the autofocus will turn on
                // only in case the name is empty
                autofocus: (null == widget.name) || (widget.name.isEmpty),
                controller: _nameFieldController,
                decoration: InputDecoration(
                  labelText: allTranslations.text('name'),
                  border: OutlineInputBorder(),
                  errorText:
                      !_isValid() ? allTranslations.text('name_missing') : null,
                ),
                style: Theme.of(context).textTheme.headline6,
                maxLength: 40,
              )),
    );
  }
}
