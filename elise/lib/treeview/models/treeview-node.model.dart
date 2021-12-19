import 'package:equatable/equatable.dart';

class TreeViewNode extends Equatable {
  final String? key;
  final String? value;
  final List<TreeViewNode>? children; 

  bool get isParent => key != null;

  TreeViewNode({this.key, this.value, this.children}) {
    assert(key == null && value == null || key != null && value != null);
  }

  TreeViewNode copyWith({String? key, String? value, List<TreeViewNode>? children }) {
    return TreeViewNode(
      key: key ?? this.key,
      value: value ?? this.value,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [key, value, children];
}
