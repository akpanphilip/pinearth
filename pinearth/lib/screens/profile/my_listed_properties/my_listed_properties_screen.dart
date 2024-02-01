import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/providers/user/my_listing_provider.dart';
import 'package:pinearth/providers/user/profile_provider.dart';
import 'package:pinearth/screens/auth/login_screen.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/empty_state_widget.dart';

import '../widgets/my_listed_property_widget.dart';

class MyListedPropertiesScreen extends ConsumerStatefulWidget {
  const MyListedPropertiesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyListedPropertiesScreenState();
}

class _MyListedPropertiesScreenState
    extends ConsumerState<MyListedPropertiesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(profileProvider).profileState.data == null) {
        Future.delayed(Duration.zero, () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        });
      } else {
        ref.read(myPropertyListingProvider).initialize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mypropertylistingprovider = ref.watch(myPropertyListingProvider);
    final mypropertylistingstate = mypropertylistingprovider.myListingState;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: const AppbarTitle(
          text: 'My Listed Properties',
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: SafeArea(child: Builder(builder: (context) {
        if (mypropertylistingstate.isLoading()) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (mypropertylistingstate.isError()) {
          return Center(
            child: CustomErrorWidget(
              message: mypropertylistingstate.message,
              onReload: () {
                // print("in heere");
                mypropertylistingprovider.initialize();
              },
            ),
          );
        } else {
          final data = mypropertylistingstate.data ?? [];
          if (data.isEmpty) {
            return Center(
              child: EmptyStateWidget(
                message: "You have not listed any property",
                onReload: () {
                 
                  mypropertylistingprovider.initialize();
                },
              ),
            );
          } else {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: MyListedPropertyWidget(property: data[index]),
                );
              },
            );
          }
        }
      })),
    );
  }
}
