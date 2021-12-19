import 'dart:io';

import 'package:elise/home/home.page.dart';
import 'package:elise/treeview/cubit/treeview.cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Elise"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  late String? jsonData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    jsonData = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () async {
              String? selectedDirectory =
                  await FilePicker.platform.getDirectoryPath();

              if (selectedDirectory != null) {
                print(selectedDirectory);
                Directory dir = Directory(selectedDirectory);
                List<File> files = dir
                    .listSync()
                    .whereType<File>()
                    .where((File file) =>
                        lookupMimeType(file.path) == "application/json")
                    .toList();

                jsonData = await (files[0].readAsString());

                setState(() {
                  print(jsonData);
                });

                for (File file in files) {
                  print(file);
                }
              }
            },
            child: Container(
              color: Colors.blue,
              child: const Text("Open file dialog"),
            ),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          BlocProvider<TreeViewCubit>(
            create: (context) => TreeViewCubit()..load(jsonData),
            child: HomePage(
            ),
          ),
        ],
      ),
    );
  }
}
