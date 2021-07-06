import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      if (Platform.isIOS)
        return CupertinoActionSheet(
          title: Text('Selecionar foro para o item'),
          message: Text('Escolha a origem da foto'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {},
              child: Text('Câmera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {},
              child: Text('Galeria'),
            ),
          ],
        );
      else
        return BottomSheet(
            onClosing: () {},
            builder: (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                        onPressed: () async {
                          try {
                            final file = await picker.getImage(
                                source: ImageSource.camera);
                            onImageSelected(File(file!.path));
                          } catch (e) {
                            print(e);
                          }
                          //Navigator.of(context).pop(File(file!.path));
                        },
                        child: Text('Câmera')),
                    TextButton(
                        onPressed: () async {
                          try {
                            final file = await picker.getImage(
                                source: ImageSource.gallery);
                            onImageSelected(File(file!.path));
                          } catch (e) {
                            print(e);
                          } //Navigator.of(context).pop(File(file!.path));
                        },
                        child: Text('Galeria')),
                  ],
                ));
    } else {
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                      onPressed: () async {
                        try {
                          final file =
                              await picker.getImage(source: ImageSource.camera);
                          onImageSelected(File(file!.path));
                        } catch (e) {
                          print(e);
                        }
                        //Navigator.of(context).pop(File(file!.path));
                      },
                      child: Text('Câmera')),
                  TextButton(
                      onPressed: () async {
                        try {
                          final file = await picker.getImage(
                              source: ImageSource.gallery);
                          onImageSelected(File(file!.path));
                        } catch (e) {
                          print(e);
                        }
                        //Navigator.of(context).pop(File(file!.path));
                      },
                      child: Text('Galeria')),
                ],
              ));
    }
  }
}
