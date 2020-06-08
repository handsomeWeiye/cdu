import 'package:cdu_helper/apis/api.dart';
import 'package:cdu_helper/beans/article_detail.dart';
import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ForumDetailsProvider with ChangeNotifier {
  int id;
  ForumDetailsProvider({this.id});

  ExtInfo authorInfo;
  ArticleDetail articleDetail;
  List commentList = [];
  bool initCompleted = false;

  Future init(int id) async {
    this.id = id;
    await CmsApi.getArticle(id: id.toString()).then((val) async {
      var jsonData = DataUtils.jsonToData(val);
      articleDetail = ArticleDetail.fromJson(jsonData);
      await getAuthorInfo(articleDetail);
      // await getArticleContent(articleDetail);
    });
    await CmsApi.getCommentList(refId: id.toString()).then((val) {
      var jsonData = DataUtils.jsonToData(val);
      print(jsonData);
      if (jsonData['code'] == 700) {
        print('没有评论');
        commentList = [];
      }
      if (jsonData['code'] == 0) {
        print('有评论');
      }
    });
    initCompleted = true;
    notifyListeners();
  }

  Future getAuthorInfo(ArticleDetail articleDetail) async {
    debugPrint(articleDetail.data.extInfo.toString());
    if (articleDetail.data.extInfo == null) {
      authorInfo.authorName = 'null';
      authorInfo.authorPic =
          'http://files.weiye.site/cuser/24022/2020/05/31/35d8d10a-233a-46cf-8635-4fb96f9c5b1b.jpg';
    } else {
      authorInfo = articleDetail.data.extInfo;
    }
  }
  // Future getArticleContent(ArticleDetail articleDetail)async{
  //      articleContent = articleDetail.data.content;
  //  }
  // Future getCommentList(ArticleDetail articleDetail)async{
  //      commentList = articleDetail.data.extInfo;
  //  }

  Future addComment(String message) async {
    debugPrint(id.toString());
    await CmsApi.addComment(
      content: message,
      refId: id.toString(),
      token: SpUtils.getTokenSync(),
    ).then((val) {
      showToast('评论成功');
    });
    debugPrint('已经发送评论');
    notifyListeners();
  }

  Future addArticle(String title, String content) async {
    await UserApi.loginAdmin().then((val) {
      String xtoken = val;
      print(xtoken);
      CmsApi.addAdminArticle(
        title: title,
        content: content,
        xToken: xtoken
      ).then((val) {
        print(val);
        var data = DataUtils.jsonToData(val);
        if (data['code'] == 0) {
          showToast('发布文章成功');
          navigatorState.pushReplacementNamed('/forum');
        } else {
          showToast('发布文章失败');
        }
      });
    });
    debugPrint('已经发布文章');
    notifyListeners();
  }
}
