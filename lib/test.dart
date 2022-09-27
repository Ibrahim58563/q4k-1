import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q4k/firebase_api.dart';

import 'firebase_file.dart';
import 'image_page.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  // 1- crating firebase
  late Future<List<FirebaseFile>> futureFiles;
  Map<int, double> downloadProgress = {};

  // final island = FirebaseStorage.instance.ref();

  // final appDocDir = await getApplicationDocumentsDirectory();
  // final path = '${appDocDir.path}/${island.name}';
  // 2- calling files
  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Some error occured'),
                  );
                } else {
                  final files = snapshot.data!;
                  return Column(
                    children: [
                      buildHeader(files.length),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return buildFile(context, file);
                        },
                        itemCount: files.length,
                      ))
                    ],
                  );
                }
            }
          }),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(
            file: file,
          ),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.copy,
            color: Colors.white,
          ),
        ),
      );

  // trying documentation
  Future downloadFile(int index, Reference ref) async {
    //   final ref = FirebaseStorage.instance.ref();

    //   final dir = await getApplicationDocumentsDirectory();
    //   final file = File('${dir.path}/${ref.name}');
    //   await ref.writeToFile(file);

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Text(
    //       'Downloaded ${ref.name}',
    //     )),
    //   );
  }
}
