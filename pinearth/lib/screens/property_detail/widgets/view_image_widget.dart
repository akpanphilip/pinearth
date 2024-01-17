import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

class ViewImageWidget extends StatefulWidget {
  const ViewImageWidget({
    super.key,
    required this.title,
    required this.images
  });

  final String title;
  final List<String> images;

  @override
  State<ViewImageWidget> createState() => _ViewImageWidgetState();
}

class _ViewImageWidgetState extends State<ViewImageWidget> {
  int currentPage = 0;
  final pageController = PageController();

  void navigate(int page) {
    pageController.animateToPage(page, duration: Duration(milliseconds: 100), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.images[index].addRemotePath,
                    fit: BoxFit.cover,
                  );
                },
                onPageChanged: (int p) {
                  setState(() {
                    currentPage = p;
                  });
                },
              ),
            ),
            // Positioned(
            //   top: 30, left: 0, right: 0,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 19, horizontal: 17),
            //     child: Row(
            //       children: [
            //         InkWell(
            //           onTap: () => Navigator.pop(context),
            //           child: Icon(Icons.arrow_back, color: Colors.white,)
            //         ),
            //         29.toRowSpace(),
            //         Text(widget.title, style: TextStyle(
            //           fontSize: 20.toFontSize(),
            //           fontWeight: FontWeight.w800, color: Colors.white
            //         ),)
            //       ],
            //     ),
            //   ),
            // ),

            Positioned(
              bottom: 24, right: 42,
              child: Text("${currentPage + 1}/${widget.images.length}", style: TextStyle(
                fontSize: 16.toFontSize(),
                fontWeight: FontWeight.w500, color: Colors.white
              ),),
            ),

            Positioned(
              left: 0, right: 0,
              top: 401,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (currentPage != 0) {
                          navigate(currentPage - 1);
                        }
                      },
                      child: Icon(Icons.keyboard_arrow_left, size: 35, color: Colors.white,)),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (currentPage != widget.images.length - 1) {
                          navigate(currentPage + 1);
                        }
                      },
                      child: Icon(Icons.keyboard_arrow_right, size: 35, color: Colors.white,)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}