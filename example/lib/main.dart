import 'package:catchimagebox/catchimagebox.dart';
import 'package:example/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ImageBoxService.initialize();
  ImageBoxService.setBaseUrl(
      'https://via.placeholder.com'); //https://via.placeholder.com/150/92c952
  // await ImageBoxService.clean();

  runApp(const MyApp());
}
