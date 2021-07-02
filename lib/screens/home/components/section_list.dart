import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/section_model.dart';
import 'package:loja_virutal_app/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(section.items[index].image!,
                  fit: BoxFit.cover,),
                );
              },
              separatorBuilder: (_, __) => SizedBox(
                width: 4,
              ),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
