import 'package:flutter/material.dart';

// Utils
import '../../utils/utils.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Dimensions().getHeight(context),
        width: Dimensions().getWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesPath.backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              ImagesPath.logoPath,
              height: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.headline,
            )
          ],
        ),
      ),
    );
  }
}
