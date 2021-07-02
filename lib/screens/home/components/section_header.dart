import 'package:flutter/material.dart';
import 'package:loja_virutal_app/models/section_model.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.section);

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
