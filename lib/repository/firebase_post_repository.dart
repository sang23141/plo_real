import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/constants/firebase_contants.dart';
import 'package:plo/model/post_model.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebasePostRepository {
  final Ref ref;
  FirebasePostRepository(this.ref);
  final firestoreinstance = FirebaseFirestore.instance;

  void _logHelper(String typeofAction, String functionName) {
    logToConsole("Firestore was used $typeofAction in $functionName in FirebasePostRepository");
  }

  Future<bool> uploadPostFirebase(PostModel postModel, bool isforEdit) async {
    try {
      if (isforEdit) {
        await firestoreinstance.collection(FirebaseConstants.postcollectionName).doc(postModel.pid).update(postModel.toJson());
      } else {
        await firestoreinstance.collection(FirebaseConstants.postcollectionName).doc(postModel.pid).set(postModel.toJson());
      }
      return true;
    } catch (error) {
      logToConsole("UploadPostModelrror : error ${error.toString()}");
      return false;
    }
  }

  //fetching category by the upload time
  Future<List<PostModel>?> fetchPost({Timestamp? lastPostUploadTime, int amountFetch = 10}) async {
    try {
      final QuerySnapshot querySnapshot;

      if (lastPostUploadTime == null) {
        querySnapshot = await firestoreinstance
            .collection(FirebaseConstants.postcollectionName)
            // .where(PostModelFieldNameConstants.category, whereIn: [
            //   CategoryType.information.toString(),
            //   CategoryType.general.toString(),
            // ])
            .orderBy(PostModelFieldNameConstants.uploadTime, descending: true)
            .limit(amountFetch)
            .get();
      } else {
        querySnapshot = await firestoreinstance
            .collection(FirebaseConstants.postcollectionName)
            // .where(PostModelFieldNameConstants.category,
            //     whereIn: [CategoryType.information.toString()])
            .orderBy(PostModelFieldNameConstants.uploadTime, descending: true)
            .limit(amountFetch)
            .get();
      }

      final List<PostModel> fetchedPosts = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        final post = PostModel().fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>);
        if (post != null) fetchedPosts.add(post);
      }
      return fetchedPosts;
    } catch (error) {
      return null;
    }
  }

  Future<List<PostModel>?> fetchPostsSameCategory(CategoryType categoryType, String excludePid, Timestamp? lastUploadedTime) async {
    List<PostModel> postModel = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (lastUploadedTime == null) {
        querySnapshot = await firestoreinstance
            .collection(FirebaseConstants.postcollectionName)
            .where(PostModelFieldNameConstants.category, isEqualTo: categoryType.toString())
            .where(PostModelFieldNameConstants.pid, isNotEqualTo: excludePid)
            .orderBy(PostModelFieldNameConstants.uploadTime, descending: true)
            .limit(10)
            .get();
      } else {
        querySnapshot = await firestoreinstance
            .collection(FirebaseConstants.postcollectionName)
            .where(PostModelFieldNameConstants.category, isEqualTo: categoryType.toString())
            .where(PostModelFieldNameConstants.pid, isNotEqualTo: excludePid)
            .orderBy(PostModelFieldNameConstants.uploadTime, descending: true)
            .limit(10)
            .startAfter([lastUploadedTime]).get();
      }
      final List<PostModel> fetchedPosts = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        final post = PostModel().fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>);
        if (post != null) fetchedPosts.add(post);
      }
      return fetchedPosts;
    } catch (error) {
      logToConsole("Error was caused during the fetchPostSameCategoryFunction ${error.toString()}");
      return null;
    }
  }

  Future<List<PostModel>?> fetchPostsSameCategoryFromOtherUsers(CategoryType categoryType, String excludepid) async {
    List<PostModel> postModels = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestoreinstance
          .collection(FirebaseConstants.postcollectionName)
          .where(PostModelFieldNameConstants.category, isEqualTo: categoryType.toString())
          .limit(10)
          .get();
      if (querySnapshot.size > 0) {
        for (int i = 0; i < querySnapshot.size; i++) {
          final PostModel? post = PostModel().fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>);
          if (post != null) postModels.add(post);
        }
      } else {
        return [];
      }
      return postModels;
    } catch (error) {
      logToConsole("Error has occured ${error.toString()}");
      return null;
    }
  }

  Future<PostModel?> fetchPostByPostUid(String pid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestoreinstance.collection(FirebaseConstants.postcollectionName).doc(pid).get();
      if (documentSnapshot.exists) {
        return PostModel().fromJson(documentSnapshot.data()!);
      } else {
        return null;
      }
    } catch (error) {
      logToConsole("Fetch by singlePost error: ${error.toString()}");
      return null;
    }
  }

  Future<bool> deletePostbyPid(String pid) async {
    try {
      await firestoreinstance.collection(FirebaseConstants.postcollectionName).doc(pid).delete();
      return true;
    } catch (e) {
      logToConsole("There was an error deleting the post ${e.toString()}");
      return false;
    }
  }

  Future<int> updateViews(List<String> updatedViews, PostModel post) async {
    try {
      await firestoreinstance.collection(FirebaseConstants.postcollectionName).doc(post.pid).update(
          {PostModelFieldNameConstants.postViewList: updatedViews, PostModelFieldNameConstants.postViewListLength: updatedViews.length});
      _logHelper("update", "updatedViews");
      return updatedViews.length;
    } catch (error) {
      logToConsole("UpdatedViews error ${error.toString()}");
      return -1;
    }
  }

  Future<List<PostModel>?> fetchUsersSixOtherPosts({
    required String userUid,
    required String excludePostUid,
  }) async {
    List<PostModel> fetchedPostList = [];
    try {
      QuerySnapshot querySnapshot = await firestoreinstance
          .collection(FirebaseConstants.postcollectionName)
          .where(PostModelFieldNameConstants.uploadUserUid, isEqualTo: userUid)
          .where(PostModelFieldNameConstants.pid, isNotEqualTo: excludePostUid)
          .limit(6)
          .get();
      _logHelper("Get", "fetchUsersThreeOtherPosts");
      for (int i = 0; i < querySnapshot.size; i++) {
        final post = PostModel().fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>);
        if (post != null) fetchedPostList.add(post);
      }
      return fetchedPostList;
    } catch (error) {
      logToConsole("Error doing fetchUsersThreeOtherPosts ${error.toString()}");
      return null;
    }
  }

  Future<List<PostModel>?> getUsersActivePost({required String userUid}) async {
    List<PostModel> usersPostList = [];
    try {
      QuerySnapshot snapshot = await firestoreinstance
          .collection(FirebaseConstants.postcollectionName)
          .where(PostModelFieldNameConstants.uploadUserUid, isEqualTo: userUid)
          .get();
      if (snapshot.size > 0) {
        for (int i = 0; i < snapshot.size; i++) {
          PostModel? post = PostModel().fromJson(snapshot.docs[i].data() as Map<String, dynamic>);
          if (post != null) {
            usersPostList.add(post);
          }
        }
      } else {
        return null;
      }
      return usersPostList;
    } catch (error) {
      logToConsole("Error was occured ${error.toString()}");
      return null;
    }
  }

  Future<List<PostModel>?> fetchMultiplePostsFromHitList(List<String> uidList) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
    PostModel? post;
    try {
      List<PostModel> postModels = [];
      for (int i = 0; i < uidList.length; i++) {
        documentSnapshot = await db.collection(FirebaseConstants.postcollectionName).doc(uidList[i]).get();
        if (documentSnapshot.data() != null) {
          post = PostModel().fromJson(documentSnapshot.data()!);
          if (post != null) {
            postModels.add(post);
          }
        }
      }
      return postModels;
    } catch (err) {
      logToConsole('fetchMultipleItemsFromHitList error: ${err.toString()}');
      return null;
    }
  }
}

final firebasePostRepositoryProvider = Provider<FirebasePostRepository>((ref) {
  return FirebasePostRepository(ref);
});
