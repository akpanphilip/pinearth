import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/backend/domain/models/entities/agent_model.dart';
import 'package:pinearth/screens/find_agent/agent_detail_screen.dart';
import 'package:pinearth/screens/find_agent/widget/start_rating_widget.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class AgentWidget extends StatelessWidget {
  const AgentWidget({super.key, required this.agent, this.showBookNow = false});

  final AgentModel agent;
  final bool showBookNow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AgentDetailScreen(agent: agent)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.20),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                  spreadRadius: 0)
            ]),
        padding: const EdgeInsets.fromLTRB(18, 19, 18, 13),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(agent.profilePhoto ?? "")),
                10.toRowSpace(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        String name = "";

                        if (agent.user.firstName.trim() != "" &&
                            agent.user.lastName != null &&
                            agent.user.lastName!.trim() != "") {
                          name =
                              "${agent.user.firstName} ${agent.user.lastName}";
                        }

                        if (agent.name != null && agent.name!.trim() != "") {
                          name = agent.name!;
                        }

                        if (agent.companyName != null &&
                            agent.companyName!.trim() != "") {
                          name = agent.companyName!;
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
                      Row(
                        children: [
                          StarRatingWidget(
                            rating: agent.rating ?? 0,
                          ),
                          if (agent.review != null && !showBookNow) ...[
                            3.toRowSpace(),
                            Text(
                              "(${agent.review!.length})",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.toFontSize(),
                                  color: Colors.black.withOpacity(.5)),
                            ),
                          ]
                        ],
                      ),
                      3.toColumnSpace(),
                      if (agent.review != null && showBookNow)
                        Text(
                          "(${agent.review!.length})",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.toFontSize(),
                              color: Colors.black.withOpacity(.5)),
                        ),
                      if (!showBookNow) ...[
                        3.toColumnSpace(),
                        Row(
                          children: [
                            SvgPicture.asset('telephone'.svg),
                            8.toRowSpace(),
                            Expanded(
                              child: Text(
                                agent.phoneNo!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18.toFontSize(),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(.5)),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                )
              ],
            ),
            10.toColumnSpace(),
            if (showBookNow)
              Row(
                children: [
                  SvgPicture.asset('telephone'.svg),
                  8.toRowSpace(),
                  Expanded(
                    child: Text(
                      agent.phoneNo!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18.toFontSize(),
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(.5)),
                    ),
                  ),
                ],
              ),
            10.toColumnSpace(),
            if (showBookNow)
              CustomButtonWidget(
                  color: appColor.primary,
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AgentDetailScreen(agent: agent)));
                  },
                  child: Center(
                    child: Text(
                      "Book now",
                      style: TextStyle(
                          fontSize: 20.toFontSize(),
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
