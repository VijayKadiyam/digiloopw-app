import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Scoped Model
import '../scoped_models/main_sm.dart';

class TakeImageWidget extends StatefulWidget {
  final MainModel model;
  final String imagePath;
  final int salesOrderId;

  TakeImageWidget({
    @required this.model,
    @required this.imagePath,
    @required this.salesOrderId,
  });

  @override
  _TakeImageWidgetState createState() => _TakeImageWidgetState();
}

class _TakeImageWidgetState extends State<TakeImageWidget> {
  final Map<String, dynamic> paymentData = {
    'ref_no': '-',
    'date': '-',
    'bank': '-',
    'amount': '-',
    'status': '-',
    'fileName': '',
    'file': '',
  };
  File _storedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            (widget.imagePath != null && widget.imagePath != '')
                ? Container(
                    height: 50,
                    child: Image.network(
                      widget.model.mediaUrl + widget.imagePath,
                    ),
                  )
                : (_storedFile != null)
                    ? Container(
                        height: 50,
                        child: Image.file(_storedFile),
                      )
                    : Text(''),
            IconButton(
              color: Colors.blue,
              icon: Icon(Icons.camera),
              onPressed: () async {
                final imageFile = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 100,
                );
                setState(() {
                  _storedFile = imageFile;
                  print(_storedFile);
                  paymentData['file'] = imageFile.path;
                  paymentData['fileName'] = 'payment.jpg';
                  widget.model.addPayment(
                    paymentData: paymentData,
                  );
                  if (widget.salesOrderId != null)
                    widget.model.addPaymentDetals(
                      salesOrderId: widget.salesOrderId,
                    );
                });
              },
            ),
            IconButton(
              color: Colors.blue,
              icon: Icon(Icons.photo),
              onPressed: () async {
                final imageFile = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 100,
                );
                setState(() {
                  _storedFile = imageFile;
                  paymentData['file'] = imageFile.path;
                  paymentData['fileName'] = 'payment.jpg';
                  widget.model.addPayment(
                    paymentData: paymentData,
                  );
                });
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.file_upload),
            //   onPressed: () {

            //   },
            // ),
          ],
        ),
      ],
    );
  }
}
