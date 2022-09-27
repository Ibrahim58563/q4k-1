import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  // 1- crating firebase
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  // final island = FirebaseStorage.instance.ref();

  // final appDocDir = await getApplicationDocumentsDirectory();
  // final path = '${appDocDir.path}/${island.name}';
  // 2- calling files
  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemBuilder: (context, index) {
                final file = files[index];
                double? progress = downloadProgress[index];
                return ListTile(
                  title: Text(file.name),
                  subtitle: progress != null
                      ? LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.blueAccent,
                        )
                      : null,
                  trailing: IconButton(
                    icon: Icon(
                      Icons.download,
                      color: Colors.black,
                    ),
                    onPressed: () => downloadFile(index, file),
                  ),
                );
              },
              itemCount: files.length,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // trying documentation
  Future downloadFile(int index, Reference ref) async {
    final ref = FirebaseStorage.instance.ref();

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${ref.name}';
    final file = File(path);

    final DownloadTask = ref.writeToFile(file);
    DownloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // TODO: Handle this case.
          break;
        case TaskState.paused:
          // TODO: Handle this case.
          break;
        case TaskState.success:
          // TODO: Handle this case.
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          break;
        case TaskState.error:
          // TODO: Handle this case.
          break;
      }
    });
  }

  // Future downloadFile(int index, Reference ref) async {
  //   final url = await ref.getDownloadURL();
  //   final tempDir = await getTemporaryDirectory();
  //   final path = '${tempDir.path}/${ref.name}';
  //   await Dio().download(url, path, onReceiveProgress: (recevied, total) {
  //     double progress = recevied / total;

  //     setState(() {
  //       downloadProgress[index] = progress;
  //     });
  //   });

  //   if (url.contains('.png')) {
  //     await GallerySaver.saveImage(path, toDcim: true);
  //   } else if (url.contains('.jpg')) {
  //     await GallerySaver.saveImage(
  //       path,
  //       toDcim: true,
  //     );
  //   }

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //         content: Text(
  //       'Downloaded ${ref.name}',
  //     )),
  //   );
  // }
}
