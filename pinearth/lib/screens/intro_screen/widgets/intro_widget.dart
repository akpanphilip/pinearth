import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinearth/backend/domain/services/i_local_storage_service.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/screens/widgets/custom_button_widget.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/styles/colors.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,

    required this.artpPath,
    required this.description,
    required this.title,
    required this.buttonText
  });

  final String artpPath;
  final String description;
  final String title;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(artpPath),

        26.toColumnSpace(),
        Text(title, style: TextStyle(
          fontSize: 30.toFontSize(),
          fontWeight: FontWeight.w700,
          color: Colors.black
        ),),

        25.toColumnSpace(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(description, style: TextStyle(
            fontSize: 14.toFontSize(),
            fontWeight: FontWeight.w400,
            color: Colors.black
          ), textAlign: TextAlign.center),
        ),

        25.toColumnSpace(),

        SizedBox(
          width: 205,
          child: CustomOutlineButtonWidget(
            child: Center(
              child: Text(buttonText),
            ), 
            onClick: () {
              getIt<ILocalStorageService>().setItem(appDataBoxKey, seenIntroKey, true).then((value) {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => RootScreen()), (route) => false);
              });
            },
            borderColor: Color(0xFF1173AB),
            color: Colors.transparent,
          ),
        )

      ],
    );
  }
}