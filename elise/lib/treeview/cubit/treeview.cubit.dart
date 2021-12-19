import 'dart:convert';

import 'package:elise/treeview/cubit/treeview.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreeViewCubit extends Cubit<TreeViewState> {
  static TreeViewCubit of(BuildContext context) =>
      BlocProvider.of<TreeViewCubit>(context);

  TreeViewCubit() : super(const TreeViewState.initialState());

  void load(String? jsonSource) {
    if (jsonSource != null) {
      emit(
        state.copyWith(
          parsedJsonSource: json.decode(jsonSource),
        ),
      );
    }
  }
}
