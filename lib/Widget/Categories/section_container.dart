import 'dart:convert';

import 'package:cityinpocket/Constant/Carousel/categories_section.dart';
import 'package:cityinpocket/Constant/style.dart';
import 'package:cityinpocket/Widget/Categories/section_item.dart';
import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer(
      {Key? key, required this.listOfElements, required this.heading})
      : super(key: key);
  final List<dynamic> listOfElements;
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            heading,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.headline1,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          crossAxisCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(listOfElements.length, (index) {
            Map<String, dynamic> element =
                listOfElements[index] as Map<String, dynamic>;
            return SectionItem(
              icon: element['icon'],
              title: element['title'],
              route: element['route'],
            );
          }),
        )
      ],
    );
  }
}
