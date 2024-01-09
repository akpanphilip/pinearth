import 'package:flutter/material.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../../utils/styles/colors.dart';

class HowToUseVideoTutorialScreen extends StatefulWidget {
  const HowToUseVideoTutorialScreen({super.key, required this.forUser});

  final bool forUser;

  @override
  State<HowToUseVideoTutorialScreen> createState() =>
      _HowToUseVideoTutorialScreenState();
}

class _HowToUseVideoTutorialScreenState
    extends State<HowToUseVideoTutorialScreen> {
  List<String> titles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.forUser) {
        titles = [
          "How to search",
          "How to rent a house",
          'How to buy a house',
          'How to lease a shortlet',
          'How to book a hotel',
          'How to contact a seller',
          'How to contact a seller'
        ];
      } else {
        titles = [
          'How register as a business',
          'How to list a property',
          'How to buy a house'
        ];
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color here
        ),
        title: AppbarTitle(
          text: (widget.forUser) ? "For Users" : "For businesses",
        ),
        centerTitle: false,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemCount: titles.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemBuilder: (context, index) {
              if (index != titles.length - 1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[index]),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(70),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Center(child: Image.asset('youtube_red'.png)),
                    )
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[index]),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(70),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Center(child: Image.asset('youtube_red'.png)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: appColor.primary,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Image.asset("plane_frame".png),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            children: [
                              Text("Send your complaints to",
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "support@pinearth.com",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
