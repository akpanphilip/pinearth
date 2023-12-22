import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/user/register_an_agent_provider.dart';
import 'package:pinearth/screens/root_screen.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

class AgentRegistrationCompleteScreen extends ConsumerWidget {
  const AgentRegistrationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerasagentprovider = ref.read(registerAsAgentProvider);
    final isEdit = registerasagentprovider.isEdit;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: AppbarTitle(
          text: '${isEdit ? 'Update' : 'Registration'} complete',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            100.toColumnSpace(),
            const Center(
              child: Image(image: AssetImage('assets/images/success.png'), height: 80, width: 80,)
            ),
            43.toColumnSpace(),
            // FormTitle(text: ),
            Text('We are reviewing your ${isEdit ? 'update' : 'details'}',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800)),
            18.toColumnSpace(),

            const DescriptionText(
              text: 'And will get back to you as soon as we can'
            ),
            79.toColumnSpace(),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xff1173AB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => RootScreen()),
                        (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ),
            ),
          ],
        ),
    );
  }
}