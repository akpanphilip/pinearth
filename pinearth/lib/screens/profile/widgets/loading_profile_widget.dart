import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:redacted/redacted.dart';

class LoadingProfileWidget extends StatelessWidget {
  const LoadingProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        100.toColumnSpace(),
        const Image(image: AssetImage('assets/images/user.png')).redact(),
                      const SizedBox(height: 10),
                      Center(
                        child: Text('firstname lastname',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700, fontSize: 18)).redact(),
                      ),
                      const SizedBox(height: 20).redact(context),
      ],
    );
  }
}