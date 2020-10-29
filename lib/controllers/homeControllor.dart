import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList data = [].obs;

  Future<void> loadFile(String mydata) async {
    // final mydata = await rootBundle.loadString("assets/baseball.csv");
    final List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(mydata);
    data.value = csvTable;
    // print(data[0]);
  }

  Future<void> openFileExplorer() async {
    try {
      final FilePickerResult res = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          onFileLoading: (c) {
            print(c.index);
          },
          allowedExtensions: ['csv'],
          withData: true);
      final fg = res.files[0].bytes;
      final asc = ascii.decode(fg);
      if (asc.contains("\n")) {
        print(asc.indexOf("\n"));
      }
      // print(String.fromCharCodes(fg));
      loadFile(ascii.decode(fg));

      // print(utf8.decode(fg));
    } on PlatformException catch (e) {
      print("Unsupported operation$e");
    } catch (ex) {
      print(ex);
    }
  }
}
