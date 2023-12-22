// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/empty_state_widget.dart';

import '../custom_widgets/custom_widgets.dart';
import '../models/update_location_model.dart';

class UpdatesScreen extends ConsumerStatefulWidget {
  const UpdatesScreen({super.key});

  @override
  ConsumerState<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends ConsumerState<UpdatesScreen> {

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration.zero, () {
      ref.read(profileProvider).loadNotifications(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppbarTitle(
            text: 'Updates',
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(IconlyLight.notification, color: Colors.black),
          )
        ],
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final notificationState = ref.watch(profileProvider).notificationState;
            if (notificationState.isLoading()) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LoadingUpdateWidget(location: ""),
                  );
                },
              );
            }
            if (notificationState.isError()) {
              return Center(
                child: CustomErrorWidget(message: notificationState.message, onReload: () => ref.read(profileProvider).loadNotifications(context)),
              );
            }
            final data = notificationState.data ?? [];
            if (data.isEmpty) {
              return Center(
                child: EmptyStateWidget(
                  message: "You do not have any update",
                  onReload: () => ref.read(profileProvider).loadNotifications(context),
                ),
              );
            }
            return ListView.builder(
              itemCount: updateLocation.length,
              itemBuilder: (context, index) {
                final notification = data[index];
                return UpdateWidget(
                  // locationImg: locationUpdate['locationImg'] as String,
                  location: notification.text,
                );
              });
          },
        ),
        // child: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       UpdateWidget(location: 'Alakashia'),
        //       UpdateWidget(location: 'No. 4 New GRA'),
        //       UpdateWidget(location: 'Pipeline'),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 18),
        //         child: Center(
        //           child: ViewLink(text: 'View all'),
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SubTitle(text: 'Agents'),
        //           AgentList(name: 'Agent John Griff'),
        //           AgentList(name: 'Agent John Griff'),
        //           AgentList(name: 'Agent John Griff'),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 18),
        //             child: Center(
        //               child: ViewLink(text: 'View all'),
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
