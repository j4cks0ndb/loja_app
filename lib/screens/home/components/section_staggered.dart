import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virutal_app/models/section_model.dart';
import 'package:loja_virutal_app/screens/home/components/section_header.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemBuilder: (_, index) {
              return Image.network(
                section.items[index].image!,
                fit: BoxFit.cover,
              );
            },
            itemCount: section.items.length,
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}
