import 'dart:async';

import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/material.dart';

Widget likeBar({int likeCount, int commentCount, int favoriteCount, int id}) {
  // Future<bool> onLikeButtonTap(bool isLiked) async {
  //   print(isLiked);
  //    CmsApi.addArticleUseful(id: id.toString(),token: SpUtils.getTokenSync()).then((val){
  //      print(val);
  //      return !isLiked;
  //    });

  // }

  return Container(
    margin: EdgeInsets.only(top: 5),
    padding: EdgeInsets.all(1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        LikeButton(
          likeCount: likeCount,
          // onTap: (bool isLiked) {
          //   onLikeButtonTap(isLiked);
          // },
        ),
        LikeButton(
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.comment,
              color: isLiked ? Colors.blue : Colors.grey,
            );
          },
          likeCount: commentCount,
        ),
      ],
    ),
  );
}
