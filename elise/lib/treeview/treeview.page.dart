import 'package:elise/treeview/cubit/treeview.cubit.dart';
import 'package:elise/treeview/cubit/treeview.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class TreeViewPage extends StatefulWidget {
  const TreeViewPage({Key? key}) : super(key: key);

  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  late TreeController _treeController;

  @override
  void initState() {
    super.initState();

    _treeController = TreeController(allNodesExpanded: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreeViewCubit, TreeViewState>(
      builder: (context, state) {
        if (state.parsedJsonSource == null) {
          return const Text("No json data");
        }
        return buildTree(state.parsedJsonSource);
      },
    );
  }

  Widget buildTree(dynamic parsedJsonSource) {
    try {
      return SingleChildScrollView(
        child: TreeView(
          nodes: toTreeNodes(parsedJsonSource),
          treeController: _treeController,
        ),
      );
    } on FormatException catch (e) {
      return Text(e.message);
    }
  }

  List<TreeNode> toTreeNodes(dynamic parsedJson) {
    if (parsedJson is Map<String, dynamic>) {
      return parsedJson.keys
          .map(
            (k) => TreeNode(
              content: Text('$k:'),
              children: toTreeNodes(parsedJson[k]),
            ),
          )
          .toList();
    }
    if (parsedJson is List<dynamic>) {
      return parsedJson
          .asMap()
          .map(
            (i, element) => MapEntry(
              i,
              TreeNode(
                content: Text('[$i]:'),
                children: toTreeNodes(element),
              ),
            ),
          )
          .values
          .toList();
    }
    return [
      TreeNode(
        content: Text(
          parsedJson.toString(),
        ),
      ),
    ];
  }
}
