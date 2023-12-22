import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class PropertyDetailWidget extends StatelessWidget {
  const PropertyDetailWidget({
    super.key,
    required this.property
  });

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
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
      
            PropertyFeatureTitle(title: "Property features",),
            10.toColumnSpace(),
            Row(
              children: [
                Text("2 story building", style: TextStyle(
                  fontSize: 16.toFontSize(),
                  color: Colors.black
                ),),
                24.toRowSpace(),
                Text("3 bedrooms", style: TextStyle(
                  fontSize: 16.toFontSize(),
                  color: Colors.black
                ),),
              ],
            ),
            14.toColumnSpace(),
            Row(
              children: [
                Text("200 sqr feet", style: TextStyle(
                  fontSize: 16.toFontSize(),
                  color: Colors.black
                ),),
                24.toRowSpace(),
                Text("3 Bathrooms", style: TextStyle(
                  fontSize: 16.toFontSize(),
                  color: Colors.black
                ),),
              ],
            ),
      
            14.toColumnSpace(),
            PropertyFeatureTitle(title: "Address",),
            10.toColumnSpace(),
            Text("${property.address}", style: TextStyle(
              fontSize: 16.toFontSize(),
              color: Colors.black
            ),),
      
            14.toColumnSpace(),
            PropertyFeatureTitle(
              title: "Price",
            ),
            10.toColumnSpace(),
            Text("${num.parse(property.propertyPrice).formattedMoney(currency: "NGN")}", style: TextStyle(
              fontSize: 16.toFontSize(),
              color: Colors.black
            ),),
      
            14.toColumnSpace(),
            PropertyFeatureTitle(
              title: "Map",
            ),
            10.toColumnSpace(),
            Container(
              child: Image.asset('assets/images/map.png'),
            ),
            20.toColumnSpace(),
          ],
        ),
      ),
    );
  }
}

class PropertyFeatureTitle extends StatelessWidget {
  const PropertyFeatureTitle({
    super.key,
    this.title = "Feature"
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
      fontSize: 14.toFontSize(),
      color: Colors.black.withOpacity(.5),
      fontWeight: FontWeight.w500
    ),);
  }
}