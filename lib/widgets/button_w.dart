import 'package:flutter/material.dart';

// utils
import '../utils/utils.dart';

class ButtonWidget extends StatelessWidget {
  final int id;
  final String name;
  final String url;

  ButtonWidget({
    @required this.id,
    @required this.name,
    @required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          url,
          arguments: {
            'id': id,
            'name': name,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              image: AssetImage(ImagesPath.backgroundImage), fit: BoxFit.fill),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
