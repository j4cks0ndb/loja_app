import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/product_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List<dynamic>.from(product.images as List<dynamic>),
      validator: (images) {
        if (images!.isEmpty) {
          return 'Insira ao menos uma imagem';
        }
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: <Widget>[
            CarouselSlider(
              items: state.value!.map<Widget>((e) {
                return Stack(
                  children: <Widget>[
                    if (e is String)
                      Container(child: Image.network(e as String))
                    else
                      Container(child: Image.file(e as File)),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.red,
                        onPressed: () {
                          state.value!.remove(e);
                          state.didChange(state.value);
                        },
                      ),
                    ),
                  ],
                );
              }).toList()
                ..add(InkWell(
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    iconSize: 50,
                    onPressed: () {
                      if (!kIsWeb) {
                        if (Platform.isIOS)
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                        else
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                                  onImageSelected: onImageSelected,
                                ));
                      }
                    },
                  ),
                )),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 1,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            if(state.hasError)
              Container(
                margin: EdgeInsets.only(top: 16,left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
