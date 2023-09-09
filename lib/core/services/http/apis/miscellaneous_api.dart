import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../model/comments_model.dart';
import '../../../../model/posts_model.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/helpers.dart';
import '../api_client.dart';

class MiscellaneousApi {
  static Future<List<PostsModel>> getPosts() async {
    try {
      final response = await ApiClient.instance.dio.get(
        'posts',
      );
      return List<PostsModel>.from(response.data
          .map((post) => PostsModel.fromJson(post))
          .toList());
    } catch (error) {
      return [];
    }
  }

  static Future<List<CommentsModel>> getComments({required int id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'posts/$id/comments',
      );

      return List<CommentsModel>.from(response.data.map((comment) => CommentsModel.fromJson(comment))
          .toList());
    } catch (error) {
      return [];
    }
  }

  static Future<PostsModel> getPost({required int id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'posts/$id',
      );

      return PostsModel.fromJson(response.data);

    } catch (error) {
      rethrow;
    }
  }


  static Future<void> deletePost({required int id}) async {
    try {
      await ApiClient.instance.dio.delete(
        'posts/$id',
      );
      await getPosts();
    } on DioError catch (error) {
      Helpers.debugDioError(error);
      rethrow;
    } catch (error) {
      log(error.toString());
      throw LocaleKeys.genericErrorMessage.tr();
    }
  }

}
