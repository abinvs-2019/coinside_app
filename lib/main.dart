import 'package:calicut/bloc/percentagebloc_bloc.dart';
import 'package:calicut/views/home_page.dart';
import 'package:calicut/service/api.dart';
import 'package:calicut/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: BlocProvider(
        create: (BuildContext context) =>
            PercentageblocBloc(modal: API_Provider()),
        child: HomeScreen(),
      ),
    );
  }
}
