import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinearth/utils/extensions/string_extension.dart';

import '../../backend/domain/models/entities/property_model.dart';
import '../../controller/form_validator.dart';
import '../../custom_widgets/custom_widgets.dart';
import '../../providers/properties/comment_property_provider.dart';
import '../../providers/user/profile_provider.dart';
import '../../utils/styles/colors.dart';
import 'empty_state_widget.dart';

class CommentBottomSheet extends ConsumerStatefulWidget {
  const CommentBottomSheet({super.key, required this.property});

  final PropertyModel property;

  @override
  ConsumerState<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends ConsumerState<CommentBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final commentTextController = TextEditingControllerEdit();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final commentsProvider = ref.read(commentPropertyProvider);

      commentsProvider.loadComments(widget.property.reviews ?? []);
      Future.delayed(const Duration(milliseconds: 200), () {
        if (scrollController.hasClients) {
          // if (commentsProvider.comments.isNotEmpty){
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
          // }
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentsProvider = ref.watch(commentPropertyProvider);

    return Container(
      height: MediaQuery.sizeOf(context).height / 1.5,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("(${commentsProvider.comments.length}) comments",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ]),
            ),
          ),
        ),
        (commentsProvider.comments.isEmpty)
            ? const Expanded(
                child: SingleChildScrollView(
                  child: EmptyStateWidget(
                    message: "There are currently no comments",
                  ),
                ),
              )
            : Expanded(
                child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return CommentBox(
                        commentsProvider: commentsProvider,
                        index: index,
                        property: widget.property,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: commentsProvider.comments.length),
              )),
        Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextField(
                controller: commentTextController,
                // key: const ValueKey("keyboard"),
                obscureText: false,
                isFilled: false,
                validator: (str) {
                  if (str == null || str.trim().isEmpty) {
                    return "Field cannot be empty";
                  } else {
                    return null;
                  }
                },
                // fillColor: Colors.white,
                hintText: "Comment",
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      try {
                        FocusManager.instance.primaryFocus?.unfocus();
                      } catch (e) {
                        //
                      }
                      final status = await commentsProvider.comment(
                          propertyId: widget.property.id,
                          comment: commentTextController.text,
                          context: context);
                      if (status) {
                        commentTextController.clear();
                        if (scrollController.hasClients) {
                          // if (commentsProvider.comments.isNotEmpty){
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                          // }
                        }
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.black)),
              )),
        )
      ]),
    );
  }
}

class CommentBox extends ConsumerWidget {
  const CommentBox({
    super.key,
    required this.commentsProvider,
    // required this.profileProvider,
    required this.index,
    required this.property,
  });

  final CommentPropertyProvider commentsProvider;
  final PropertyModel property;

  // final ChangeNotifierProvider<ProfileProvider> profileProvider;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("developer is ${property.developer}");

    final userProvider = ref.watch(profileProvider);
    final isNotOwner =
        (commentsProvider.comments[index].userModel!.id != property.owner!.id);

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (isNotOwner) avatar(),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment:
              isNotOwner ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment:
                  isNotOwner ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Text(
                  "${commentsProvider.comments[index].userModel!.firstName} ${commentsProvider.comments[index].userModel!.lastName}",
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                if (!isNotOwner) ...[
                  const SizedBox(
                    width: 10,
                  ),
                  if ((property.agent != null &&
                          property.agent!.isVerified != null &&
                          property.agent!.isVerified!) ||
                      (property.developer != null &&
                          property.developer!.isVerified != null &&
                          property.developer!.isVerified!) ||
                      (property.landlord != null &&
                          property.landlord!.isVerified != null &&
                          property.landlord!.isVerified!)) ...[
                    SvgPicture.asset("verified".svg),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                  Text(
                    "(owner)",
                    style: GoogleFonts.nunito(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ]
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                // margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: (isNotOwner) ? appColor.primary : appColor.green1,
                    borderRadius: BorderRadius.only(
                        topRight: (isNotOwner)
                            ? const Radius.circular(20)
                            : Radius.zero,
                        topLeft: (!isNotOwner)
                            ? const Radius.circular(20)
                            : Radius.zero,
                        bottomRight: const Radius.circular(20),
                        bottomLeft: const Radius.circular(20))),
                child: Builder(builder: (context) {
                  final stringList =
                      commentsProvider.comments[index].comment!.split(" ");
                  int highlightIndex = -1;


                  return RichText(
                    text: TextSpan(children: [
                      ...List.generate(stringList.length, (index) {
                        // print("index is ${stringList[index]}");
                        if (stringList[index].startsWith("@") &&
                            (index != stringList.length - 1)) {
                          //Color the next index
                          highlightIndex = index + 1;
                        }
                        if (stringList[index].startsWith("@") ||
                            index == highlightIndex) {
                          return TextSpan(
                              text: "${stringList[index]} ",
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ));
                        } else {
                          return TextSpan(
                              text: "${stringList[index]} ",
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ));
                        }
                      })
                    ]),
                    // child: Text("${commentsProvider.comments[index].comment}",
                    //     style: GoogleFonts.nunito(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400,
                    //       color: Colors.white,
                    //     )),
                  );
                })),
          ],
        ),
      ),
      if (!isNotOwner)
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: avatar(),
        ),
    ]);
  }

  Widget avatar() {
    return (commentsProvider.comments[index].userModel!.profile!.avatar ==
                null ||
            commentsProvider.comments[index].userModel!.profile!.avatar
                    .trim() ==
                "")
        ? const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/user.png'),
          )
        : CircleAvatar(
            radius: 20,
            // backgroundColor: Colors.red,
            backgroundImage: CachedNetworkImageProvider(
                commentsProvider.comments[index].userModel!.profile!.avatar!),
          );
  }
}
