import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../backend/domain/models/entities/agent_model.dart';
import '../../utils/styles/colors.dart';
import 'custom_button_widget.dart';

class HousingAgentCard extends StatelessWidget {
  const HousingAgentCard({super.key, required this.agentModel});

  final AgentModel agentModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 273,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: agentModel.profilePhoto,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${agentModel.user.firstName} ${agentModel.user.lastName}",
                        maxLines: 1,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ...List.generate(
                              5,
                              (index) => Icon(
                                    (index + 1 <= (agentModel.rating ?? 0))
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color: appColor.primary,
                                  ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "(300)",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (agentModel.phoneNo.trim() != "")
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(agentModel.phoneNo,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.5))),
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            CustomButtonWidget(
              onClick: () {},
              color: appColor.primary,
              child: Text("Book now",
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
