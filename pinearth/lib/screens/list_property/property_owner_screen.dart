import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinearth/backend/domain/models/entities/user_search_result_model.dart';
import 'package:pinearth/backend/domain/repositories/i_user_repo.dart';
import 'package:pinearth/custom_widgets/custom_widgets.dart';
import 'package:pinearth/locator.dart';
import 'package:pinearth/providers/base_provider.dart';
import 'package:pinearth/screens/widgets/custom_error_widget.dart';
import 'package:pinearth/screens/widgets/empty_state_widget.dart';
import 'package:pinearth/utils/extensions/number_extension.dart';

class PropertyOwnerScreen extends StatefulWidget {
  const PropertyOwnerScreen({super.key});

  @override
  State<PropertyOwnerScreen> createState() => _PropertyOwnerScreenState();
}

class _PropertyOwnerScreenState extends State<PropertyOwnerScreen> {

  final userState = ProviderActionState<List<UserSearchResultModel>>(data: []);
  final searchParamController = TextEditingController();

  bool searching = false;

  void searchUser() async {
    try {
      setState(() {
        userState.toLoading();
      });
      final res = await getIt<IUserRepo>().searchUser(searchParamController.text);
      res.fold((l) {
        setState(() {
          userState.toError(l.message);
        });
      }, (r) {
        setState(() {
          userState.toSuccess(r);
        });
      });
    } catch (error) {
      setState(() {
        userState.toError("Unable to search user");
      });
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      searchParamController.addListener(() {
        if (searchParamController.text.isNotEmpty) {
          searchUser();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          56.toColumnSpace(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text("Select property owner", style: TextStyle(
              fontSize: 14.toFontSize(), fontWeight: FontWeight.w700
            ),),
          ),

          24.toColumnSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomTextField(
              obscureText: false, hintText: "Search user",
              controller: searchParamController,
            )
          ),
          24.toColumnSpace(),

          Expanded(
            child: Builder(
              builder: (context) {
                if (searchParamController.text.isEmpty) {
                  return Center(
                    child: Text("Start typing to search"),
                  );
                }
                if (userState.isLoading()) {
                  return Center(
                    child: CircularProgressIndicator.adaptive()
                  );
                }
                if (userState.isError()) {
                  return CustomErrorWidget(message: userState.message, onReload: () => searchUser());
                }
                final users = userState.data ?? [];
                if (users.isEmpty) {
                  return EmptyStateWidget(
                    message: "No user found for ${searchParamController.text}",
                    onReload: () => searchUser(),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return InkWell(
                      onTap: () => Navigator.pop(context, user),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: user.profile == null ? "" : user.profile!.avatar,
                                errorWidget: (context, url, error) {
                                  return Icon(Icons.person);
                                },
                              ),
                            ),
                            17.toRowSpace(),
                            Expanded(
                              child: Text("${user.firstName} ${user.lastName}", style: TextStyle(
                                fontSize: 16.toFontSize(),
                                fontWeight: FontWeight.w400
                              ),),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          )


        ],
      ),
    );
  }
}