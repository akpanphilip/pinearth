import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../backend/domain/models/entities/property_model.dart';
import '../../custom_widgets/custom_widgets.dart';
import '../../providers/properties/comment_property_provider.dart';
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
  final commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(commentPropertyProvider)
          .loadComments(widget.property.reviews ?? []);
    });
  }

  @override
  void dispose() {
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
                    itemBuilder: (context, index) {
                      return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (commentsProvider.comments[index].userModel!
                                            .profile!.avatar ==
                                        null ||
                                    commentsProvider.comments[index].userModel!
                                            .profile!.avatar
                                            .trim() ==
                                        "")
                                ? const CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                  )
                                : CircleAvatar(
                                    radius: 20,
                                    // backgroundColor: Colors.red,
                                    backgroundImage: CachedNetworkImageProvider(
                                        commentsProvider.comments[index]
                                            .userModel!.profile!.avatar!),
                                  ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: appColor.primary,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Text(
                                      "${commentsProvider.comments[index].comment}",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ))),
                            )
                          ]);
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
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      commentsProvider.comment(
                          propertyId: widget.property.id,
                          comment: commentTextController.text,
                          context: context);
                    },
                    icon: const Icon(Icons.send, color: Colors.black)),
              )),
        )
      ]),
    );
  }
}
