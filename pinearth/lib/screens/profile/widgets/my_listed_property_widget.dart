import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/providers/user/my_listing_provider.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../../property_detail/property_detail_screen.dart';

class MyListedPropertyWidget extends ConsumerWidget {
  MyListedPropertyWidget({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailScreen(
                property: property,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        decoration: BoxDecoration(
            color: const Color(0xfffD9D9D9),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          property.houseView.first.houseView.addRemotePath),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${property.title}',
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 200,
                    child: Text(
                      '${property.address}',
                      style: GoogleFonts.nunito(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // const Image(
                //   image: AssetImage('assets/images/available.png'),
                // ),
                FlutterSwitch(
                  value: property.available!,
                  onToggle: (v) => ref
                      .read(myPropertyListingProvider)
                      .togglePropertyAvailability(property.id.toString(), v),
                  height: 18,
                  width: 30,
                  padding: 2,
                  toggleSize: 14,
                  activeColor: Colors.green,
                  inactiveColor: Colors.red,
                ),
                5.toColumnSpace(),
                Text(
                  property.available! ? 'Available' : 'Not Availble',
                  style: GoogleFonts.nunito(
                      fontSize: 12, fontWeight: FontWeight.w300),
                )
              ],
            ),
            10.toRowSpace(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.black26,
            )
            // Row(
            //   children: [
            //     const SizedBox(width: 10),

            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
