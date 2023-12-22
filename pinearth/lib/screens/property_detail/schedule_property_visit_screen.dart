import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/domain/models/entities/property_model.dart';
import 'package:pinearth/backend/domain/repositories/i_property_repo.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/properties/schedule_a_visit_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/feedback_alert/i_feedback_alert.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

final scheduleAVisitProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ScheduleAVisitProvider(
    getIt<IPropertyRepo>(),
    getIt<IAlertInteraction>()
  );
});

class SchedulePropertyVisitScreen extends ConsumerStatefulWidget {
  const SchedulePropertyVisitScreen({
    super.key,
    required this.property
  });

  final PropertyModel property;

  @override
  ConsumerState<SchedulePropertyVisitScreen> createState() => _SchedulePropertyVisitScreenState();
}

class _SchedulePropertyVisitScreenState extends ConsumerState<SchedulePropertyVisitScreen> {

  @override
  void initState() {
    super.initState();
    if (ref.read(profileProvider).profileState.data == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final scheduleAVisitP = ref.watch(scheduleAVisitProvider);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const AppbarTitle(
          text: 'Schedule a visit',
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LabelTitle(text: 'Name'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: '',
                controller: scheduleAVisitP.nameController,
              ),
              20.toColumnSpace(),


              LabelTitle(text: 'Phone number'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: '',
                controller: scheduleAVisitP.phoneNumberController,
                inputType: TextInputType.phone,
              ),
              20.toColumnSpace(),
              LabelTitle(text: 'Email'),
              10.toColumnSpace(),
              CustomTextField(
                obscureText: false, hintText: '',
                controller: scheduleAVisitP.emailController,
              ),
              20.toColumnSpace(),

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LabelTitle(text: 'Message'),
                  SizedBox(width: 5),
                  Text(
                    '(Optional)',
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
              14.toColumnSpace(),
              TextField(
                controller: scheduleAVisitP.messageController,
                decoration: InputDecoration(
                  fillColor: const Color(0xffeeeeee),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Type your message here..."
                ),
                maxLines: 5,
                minLines: 5,
              ),

              42.toColumnSpace(),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xff1173AB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    scheduleAVisitP.scheduleVisit(context, widget.property.owner.email, widget.property.owner.role);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Send Message',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}