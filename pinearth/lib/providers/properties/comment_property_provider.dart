import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../backend/domain/models/entities/property_model.dart';
import '../../backend/domain/models/entities/user_model.dart';
import '../../backend/domain/repositories/i_property_repo.dart';
import '../../locator.dart';
import '../../screens/feedback_alert/i_feedback_alert.dart';
import '../base_provider.dart';

class CommentPropertyProvider extends BaseProvider {
  final IAlertInteraction alert;
  final IPropertyRepo propertyRepo;

  CommentPropertyProvider(this.alert, this.propertyRepo);

  List<ReviewModel> comments = [];

  void loadComments(List<ReviewModel> comments) {
    this.comments = comments;
    notifyListeners();
  }

  void addComment(ReviewModel comment){
    comments.add(comment);
    notifyListeners();
  }

  Future<bool> comment({required int propertyId, required BuildContext context,required String comment}) async {
    try {
      alert.showLoadingAlert("");
      final res = await propertyRepo.commentOnProperty(propertyId,comment);

      alert.closeAlert();
      final status = res.fold((l) {
        alert.showErrorAlert(l.message);
        return false;
      }, (r) {
        addComment(r);
        alert.showSuccessAlert("Comment posted successfully");
        return true;
      });
      return status;
    } catch (e) {
      alert.closeAlert();
      alert.showErrorAlert("Unable to list property");
      return false;
    }
  }
}

final commentPropertyProvider = ChangeNotifierProvider.autoDispose((ref) {
  return CommentPropertyProvider(
    getIt<IAlertInteraction>(),
    getIt<IPropertyRepo>(),
  );
});
