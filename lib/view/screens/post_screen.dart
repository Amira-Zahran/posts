import 'package:flutter/material.dart';
import 'package:posts_app/core/widgets/custom_app_bar.dart';
import 'package:posts_app/model/comments_model.dart';
import 'package:posts_app/model/posts_model.dart';
import 'package:posts_app/view/screens/posts_screen.dart';
import 'package:provider/provider.dart';

import '../../controller/posts_provider.dart';
import '../../core/dialogs/confirmation_dialog.dart';
import '../../core/services/http/apis/miscellaneous_api.dart';
import '../../core/utils/snackbars.dart';
import '../../core/utils/util_values.dart';
import '../../core/widgets/loading_widget.dart';
import 'loca_widgets/custom_post.dart';
import 'loca_widgets/custom_replay.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});
  static const String routeName = '/post';

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as PostsModel;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Post & comments', backButton: BackButton(),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: Provider.of<PostsProvider>(context,listen:false).getComments(id: post.id ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }

                final comments = Provider.of<PostsProvider>(context,listen:false).comments;

                if (comments.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    CustomPostWidget(
                      allPosts: false,
                      description: post.body.toString(),
                      nameAuthor: post.userId.toString(),
                      voidCallbackUpvote: () => _deletePost(id: post.id ?? 0, context: context),
                      numberOfReplies: comments.length,
                      title: post.title.toString(),
                    ),
                    UtilValues.gap8,
                    Expanded(
                      child: ListView.builder(
                      itemCount: comments.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              CustomReply(
                                nameAuthor: comments[index].email.toString(),
                                title: comments[index].name.toString(),
                                description: comments[index].body.toString(),
                                voidCallbackUpvote: () {}
                              ),
                            ],
                          ),
                        );
                      },
              ),
                    ),
                  ],
                );
            }
          ),
        ),
      ),
    );
  }



  Future<void> _deletePost({
    required int id,
    required BuildContext context
  }) async {
    try {
      final confirmed = await ConfirmationDialog.show(
        context: context,
        title: 'Are you sure?',
        message: 'You want to delete this post ?',
      );

      if (!confirmed) return;
      await Provider.of<PostsProvider>(context,listen:false).deletePost(id: id).then((value) {
        showSnackbar(
          context: context,
          status: SnackbarStatus.success,
          message: 'Deleted successfully'.toString(),
        );
        Navigator.of(context).pushNamed(PostsScreen.routeName);
      });

    } catch (error) {
      showSnackbar(
        context: context,
        status: SnackbarStatus.error,
        message: error.toString(),
      );
    }
  }
}
