import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  const CustomDropdownWidget(
      {super.key,
      this.selected,
      this.hintText = "Select an option",
      required this.items,
      required this.onSelect});

  final CustomDropDownItem<T>? selected;
  final String hintText;
  final List<CustomDropDownItem<T>> items;
  final Function(CustomDropDownItem) onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Text(
                  selected == null ? hintText : selected!.label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400, fontSize: 16),
                )),
                const Icon(Icons.expand_more)
              ],
            ),
          )),
      itemBuilder: (context) {
        return [
          ...items.map((e) {
            return PopupMenuItem(
              value: e,
              child: Text(
                e.label,
              ),
              onTap: () {
                onSelect(e);
              },
            );
          }),
        ];
      },
      onSelected: (value) {},
    );
  }
}

class CustomDropDownItem<T> {
  String label;
  T value;
  CustomDropDownItem({required this.label, required this.value});
}
