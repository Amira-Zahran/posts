
import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/font.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:sizer/sizer.dart';

import 'custom_button.dart';

class CustomPostWidget extends StatelessWidget {
  final String nameAuthor;
  final String title;
  final String description;
  final VoidCallback voidCallbackUpvote;
  final int numberOfReplies;
  final bool allPosts;
  // this attributes will be increase

  const CustomPostWidget(
      {super.key,
        required this.nameAuthor,
        required this.title,
        required this.description,
        required this.voidCallbackUpvote,
        required this.numberOfReplies,required this.allPosts
      });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: UtilValues.borderRadius10,
      child: Container(
        padding: UtilValues.padding16,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: UtilValues.borderRadius10,
            /*boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                blurRadius: 40.sp,
                offset: Offset(0, 6),
              )
            ]*/),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // start section one
            Text(
              nameAuthor,
              style: TextStyle(fontSize: 14.sp, fontFamily: NSTextStyles.font, color: ColorsPalette.black ),
            ),
            // end section one
            UtilValues.gap8,
            // start title section
            Text(
              title,
              style: TextStyle(
                  color: ColorsPalette.primaryColor
                  ,fontSize: 20.sp),
            ),
            // end title section
            UtilValues.gap8,

            // start description section
            Text(
              description,
              style: TextStyle(
                  color: ColorsPalette.darkGrey,fontSize: 12.sp),
            ),
            // end description section
            UtilValues.gap24,

            Row(
              children: [
                if(allPosts)const Spacer(),
                IconButton(
                  onPressed: voidCallbackUpvote,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: ColorsPalette.red,
                  ),
                ),
                if(!allPosts)const Spacer(),

                if(!allPosts)CustomSideBarButton(
                  title: '$numberOfReplies Replies',
                  onClick: () {},
                  svg: 'assets/icon/replies_icon.svg',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
