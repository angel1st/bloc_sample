import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bloc_sample_app/local_data_sources/local_data_sources.dart';
import 'package:bloc_sample_app/repositories/repositories.dart';
import 'package:bloc_sample_app/utils/global_translations.dart';
import 'package:bloc_sample_app/presentation/blocs/bloc.dart';
import 'package:bloc_sample_app/presentation/pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase appDatabase = AppDatabase();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppDatabase>(
          create: (_) => appDatabase,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => TranslationBloc()
              ..add(
                TranslationEventLoadLanguage(),
              ),
          ),
        ],
        child: Application(),
      ),
    ),
  );
}

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: allTranslations.text('app_title'),
      debugShowCheckedModeBanner: false,

      ///
      /// Multi lingual
      ///
      locale: allTranslations.locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: allTranslations.supportedLocales(),

      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: HomePage(),
    );
  }
}
