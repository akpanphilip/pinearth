import 'package:flutter/material.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class PropertyClassTileWidget extends StatelessWidget {
  PropertyClassTileWidget(
      {super.key, this.currentClass = "All", required this.onClassChange});

  final String currentClass;
  final Function(String) onClassChange;

  final List<String> items = [
    "All",
    "For Rent",
    "For Sale",
    "Hotel",
    "Shortlet",
    "Event Center"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...items.map((e) {
                final isSelected = e == currentClass;
                return GestureDetector(
                  onTap: () {
                    onClassChange(e);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      // margin: EdgeInsets.symmetric(
                      //     horizontal: 10),
                      margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      height: 30,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xFFE6F1F7)
                            : Color(0xFFE6F1F7).withOpacity(.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize: 10.toFontSize(),
                              color:
                                  isSelected ? appColor.primary : Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ));
  }
}
