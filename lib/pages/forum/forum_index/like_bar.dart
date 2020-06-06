import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
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
Future<bool> ontaped(bool isLiked)async{print(isLiked); return true; }

  Future<bool> onLikeButtonTap(bool isLiked) async {
    bool success = true;
    await CmsApi.addArticleUseful(
            id: id.toString(), token: SpUtils.getTokenSync())
        .then((val) {
      var data = DataUtils.jsonToData(val);
      print(data);
      if (data['code'] == 0) {
         success =true;
      } else {
          success = false;
      }
    });
    return success;
  }

  return Container(
    margin: EdgeInsets.only(top: 5),
    padding: EdgeInsets.all(1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        LikeButton(
          likeCount: likeCount,
          onTap: onLikeButtonTap,
        ),
        LikeButton(
          isLiked: false,
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.comment,
              color: isLiked ? Colors.blue : Colors.grey,
            );
          },
          likeCount: commentCount,
          onTap: ontaped,
        ),
      ],
    ),
  );
}
