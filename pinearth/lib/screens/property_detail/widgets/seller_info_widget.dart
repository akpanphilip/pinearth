import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../backend/domain/models/entities/property_model.dart';
import '../../../utils/extensions/number_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/styles/colors.dart';
import '../../find_agent/agent_detail_screen.dart';
import '../../find_agent/widget/start_rating_widget.dart';
import '../../widgets/custom_button_widget.dart';

class SelletInfoWidget extends StatelessWidget {
  const SelletInfoWidget({
    super.key,
    required this.property,
  });

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          if (property.agent != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AgentDetailScreen(agent: property.agent!)));
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Column(
              children: [
                Row(children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundImage:
                      NetworkImage(property.agent?.profilePhoto ?? "")),
                  50.toRowSpace(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          String name = "";

                          if (property.agent?.user.firstName.trim() != "" &&
                              property.agent?.user.lastName != null &&
                              property.agent?.user.lastName!.trim() != "") {
                            name =
                            "${property.agent?.user.firstName} ${property.agent
                                ?.user.lastName}";
                          }

                          if (property.agent?.name != null &&
                              property.agent?.name!.trim() != "") {
                            name = property.agent!.name!;
                          }

                          if (property.agent?.companyName != null &&
                              property.agent?.companyName!.trim() != "") {
                            name = property.agent!.companyName!;
                          }

                          if (property != null) {
                            name =
                            "${property.owner.lastName} ${property.owner
                                .firstName}";
                          }

                          return Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.toFontSize()),
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                        6.toColumnSpace(),
                        StarRatingWidget(
                          rating: property.agent?.rating ?? 0,
                        ),
                        3.toColumnSpace(),
                        Text(
                          "(${property.reviews == null ? "0" : property.reviews!
                              .length})",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.toFontSize(),
                              color: Colors.black.withOpacity(.5)),
                        )
                      ],
                    ),
                  )
                ]),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    10.toColumnSpace(),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: CustomButtonWidget(
                            color: appColor.primary,
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AgentDetailScreen(
                                              agent: property.agent!)));
                            },
                            child: Center(
                              child: Text(
                                "Book now",
                                style: TextStyle(
                                    fontSize: 20.toFontSize(),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset('telephone'.svg),
                          8.toRowSpace(),
                          Expanded(
                            child: Text(
                              property.agent?.phoneNo ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.toFontSize(),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(.5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

/*
* Column(
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
*
* */
