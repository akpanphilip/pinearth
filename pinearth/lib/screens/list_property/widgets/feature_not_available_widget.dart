
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinearth/screens/find_agent/find_agent_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/app_constants.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class FeatureNotAvailableWidget extends StatelessWidget {
  const FeatureNotAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 140),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close)),
            ),
            25.toColumnSpace(),
            Text("This feature is not available yet", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 27.toFontSize(),
              fontWeight: FontWeight.w800, 
              color: Colors.black
            ),),
            16.toColumnSpace(),
            SvgPicture.asset("5".svg),
            35.toColumnSpace(),
            Text("You should:", style: TextStyle(
              fontSize: 14.toFontSize(),
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),),
            18.toColumnSpace(),
            CustomOutlineButtonWidget(
              color: Colors.white,
              borderColor: Colors.black,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Find a house agent"),
                20.toRowSpace(),
                const Icon(Icons.keyboard_arrow_right)
              ],
            ), onClick: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FindAgentScreen(
                type: agentAgentType,
              )));
            })
          ],
        ),
      ),
    );
  }
}