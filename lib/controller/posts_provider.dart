import 'package:flutter/material.dart';
import 'package:posts_app/core/services/http/apis/miscellaneous_api.dart';
import 'package:posts_app/model/comments_model.dart';

import '../model/posts_model.dart';

class PostsProvider extends ChangeNotifier {

  List<PostsModel> posts = [];
  List<CommentsModel> comments = [];

  Future<void> getPosts() async {
    try {
      posts = await MiscellaneousApi.getPosts();
    } catch (_) {
      posts = [];
    }
    notifyListeners();
  }

  Future<void> getComments({required int id}) async {
    try {
      comments = await MiscellaneousApi.getComments(id: id);
    } catch (_) {
      comments = [];
    }
    notifyListeners();
  }

  Future<void> deletePost({required int id}) async{
    try{
      await MiscellaneousApi.deletePost(id: id);
      await getPosts();
    }catch(_){}
    notifyListeners();
  }
}