import 'package:flutter/material.dart';
import 'package:posts_app/controller/posts_provider.dart';
import 'package:posts_app/view/screens/post_screen.dart';
import 'package:provider/provider.dart';
import '../../core/dialogs/confirmation_dialog.dart';
import '../../core/utils/snackbars.dart';
import '../../core/utils/util_values.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/loading_widget.dart';
import 'loca_widgets/custom_post.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});
  static const String routeName = '/posts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'All Posts', ),
      body: FutureBuilder(
              future: Provider.of<PostsProvider>(context,listen:false).getPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }

                /*final postsProvider = context.read<PostsProvider>();

                final posts = postsProvider.posts;*/

                final posts = Provider.of<PostsProvider>(context,listen:false).posts;

                if (posts.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Consumer<PostsProvider>(builder: (context, provider, _) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: UtilValues.padding8,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, PostScreen.routeName, arguments: posts[index]);
                          },
                          child: CustomPostWidget(
                            allPosts: true,
                            description: posts[index].body.toString(),
                            nameAuthor: posts[index].userId.toString(),
                            voidCallbackUpvote: () => _deletePost(id: posts[index].id ?? 0, context: context),
                            title: posts[index].title.toString(), numberOfReplies: 0,
                          ),
                        ),
                      );
                    },
                    itemCount: posts.length,
              );
                  }
                );
            }
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