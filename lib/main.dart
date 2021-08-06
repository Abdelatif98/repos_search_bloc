import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:repos_search_bloc/bloc/repos.bloc.dart';
import 'package:repos_search_bloc/pages/repos.page.dart';
import 'package:repos_search_bloc/pages/splach.page.dart';
import 'package:repos_search_bloc/services/repos.service.dart';

import 'bloc/repos.state.dart';

void main() {
  GetIt.instance.registerLazySingleton(() => ReposService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ReposBloc(
            initialState: ReposState.initialState())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        routes: {
          'repos': (context) => ReposPage(),
          'splach': (context) => SplachPage(),
        },
        initialRoute: 'splach',
      ),
    );
  }

}