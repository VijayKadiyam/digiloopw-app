import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Scoped Model
import 'scoped_models/main_sm.dart';

// Routing
import 'routing/router.dart';

// Utils
import 'utils/utils.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel model = MainModel();

  @override
  void initState() {
    getLoggedInUser();

    super.initState();
  }

  getLoggedInUser() {
    model.autoAuthenticate();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: Font.primaryFont,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
                title: TextStyle(
                  fontFamily: Font.primaryFont,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: TextStyle(
                  fontFamily: Font.primaryFont,
                  fontSize: 18,
                ),
                headline: TextStyle(
                  fontFamily: Font.primaryFont,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                subhead: TextStyle(
                  fontFamily: Font.primaryFont,
                  fontSize: 18,
                ),
              ),
        ),
      ),
    );
  }
}
