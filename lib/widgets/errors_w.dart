import 'package:flutter/material.dart';

// Scoped Models
import '../scoped_models/main_sm.dart';

class ErrorsWidget extends StatelessWidget {
  final MainModel model;

  ErrorsWidget({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        if (model.errors != null)
          Text(
            model.errors.toString(),
            style: TextStyle(
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
