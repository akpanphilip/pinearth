import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/screens/property_detail/widgets/product_detail_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class SelletInfoWidget extends StatelessWidget {
  const SelletInfoWidget({
    super.key,
    required this.property
  });
  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            22.toColumnSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("${property.owner.firstName} ${property.owner.lastName}", style: TextStyle(
                    fontSize: 16.toFontSize(),
                    fontWeight: FontWeight.w500, color: Colors.black
                  ),),
                ),
          
                SvgPicture.asset("call_seller_icon".svg)
              ],
            ),
            14.toColumnSpace(),
            const PropertyFeatureTitle(title: "Properties sold"),
            10.toColumnSpace(),
            Text("This seller hasn’t sold a home yet", style: TextStyle(
              fontSize: 16.toFontSize(),
              color: Colors.black
            ),),

            14.toColumnSpace(),
            const PropertyFeatureTitle(title: "Address"),
            10.toColumnSpace(),
            Text("${property.owner.profile?.address}", style: TextStyle(
              fontSize: 16.toFontSize(),
              color: Colors.black
            ),),

            14.toColumnSpace(),
            const PropertyFeatureTitle(title: "Phone number"),
            10.toColumnSpace(),
            Text("${property.owner.profile?.phoneNo}", style: TextStyle(
              fontSize: 16.toFontSize(),
              color: Colors.black
            ),),
          ],
        ),
      ),
    );
  }
}