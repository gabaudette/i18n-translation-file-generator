import 'package:elise/treeview/models/treeview-node.model.dart';
import 'package:equatable/equatable.dart';

class TreeViewState extends Equatable {
  final List<TreeViewNode>? tree;
  final Map<String, dynamic>? parsedJsonSource;

  const TreeViewState({required this.tree, required this.parsedJsonSource});

  const TreeViewState.initialState()
      : tree = const [],
        parsedJsonSource = const {};

  TreeViewState copyWith({
    List<TreeViewNode>? tree,
    Map<String, dynamic>? parsedJsonSource,
  }) {
    return TreeViewState(
      tree: tree ?? this.tree,
      parsedJsonSource: parsedJsonSource ?? this.parsedJsonSource,
    );
  }

  @override
  List<Object?> get props => [tree, parsedJsonSource];
}
