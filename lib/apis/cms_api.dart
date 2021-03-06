import 'package:dio/dio.dart';
import 'package:cdu_helper/utils/utils.dart';
import 'api.dart';

Future<Response<String>> response;

class CmsApi {
  static Future<Response<String>> getCmsCategories(
          {String id, String token}) async =>
      NetUtils.getX(API.getCmsCategories, data: {'id': id, 'token': token});
  static Future<Response<String>> getCmsCategoryList({String token}) async =>
      NetUtils.getX(API.getCmsCategoryList, data: {'token': token});

  static Future<Response<String>> getArticleList(
      {String categoryId,
      String keywordsLike,
      String page,
      String pageSize,
      String orderBy,
      String tagsLike,
      String token,
      String titleLike,
      String isRecommend,
      String id}) async {
    Response<String> data = await NetUtils.postX(API.getArticleList, data: {
      'categoryId': categoryId,
      'keywordsLike': keywordsLike,
      'page': page,
      'token': token,
      'titleLike': titleLike,
      'pageSize': pageSize,
      'orderBy': orderBy,
      'tagsLike': tagsLike,
      'isRecommend': isRecommend,
      'id': id
    });
    return data;
  }

  static Future<Response<String>> addArticle( {
    String categoryId,
    String title,
    String descript,
    String content,
    String token,
    String author,
    String id,
    String pic,
    String keywords,
    String extroInfo,
  }) async {
   Response<String>data = await NetUtils.postX(API.addArticle, data: {
      'content': content,
      'author': author,
      'token': token,
      'categoryId': categoryId,
      'title': title,
      'descript': descript,
      'id': id,
      'pic': pic,
      'keywords': keywords,
      'postJsonString':extroInfo,
    });
    return data;
  }
  static Future<Response<String>> addAdminArticle( {
    String categoryId,
    String title,
    String descript,
    String content,
    String token,
    String author,
    String id,
    String pic,
    String keywords,
    String extroInfo,
    String xToken,
  }) async {
   Response<String>data = await NetUtils.postWithHeaderSet(API.addAdminArticle, data: {
      'content': content,
      'author': SpUtils.getUserNickName(),
      // 'token': SpUtils.getTokenSync(),
      'categoryId': '9890',
      'title': title,
      'descript': content,
      'id': id,
      'pic': pic,
      'keywords': title,
      'status':'2',
      'extJsonStr':SpUtils.getExtroInfo(),
    },headers: {'X-Token':xToken});
    return data;
  }
  static Future<Response<String>> getArticle( {String id,String token}) async {
    Response<String> data =
        await NetUtils.getX(API.getArticle, data: {'id': id, 'token': token});
    return data;
  }

  static Future<Response<String>> getPreNextArticle(String id,
          {String token}) async =>
      NetUtils.getX(API.getPreNextArticle, data: {'id': id, 'token': token});
  static Future<Response<String>> deleteArticle(String id,
          {String token}) async =>
      NetUtils.postX(API.deleteArticle, data: {'id': id, 'token': token});

  static Future<Response<String>> getFavList(
          {String page,
          String pageSize,
          String titleLike,
          String token}) async =>
      NetUtils.postX(API.getFavList, data: {
        'page': page,
        'pageSize': pageSize,
        'titleLike': titleLike,
        'token': token
      });
  static Future<Response<String>> addFav(String id, {String token}) async =>
      NetUtils.postX(API.addFav, data: {'id': id, 'token': token});
  static Future<Response<String>> checkFav({String id, String token}) async =>
      NetUtils.getX(API.checkFav, data: {'id': id, 'token': token});
  static Future<Response<String>> deleteFav(
          {String id, String newsId, String token}) async =>
      NetUtils.postX(API.deleteFav,
          data: {'id': id, 'newsId': newsId, 'token': token});

  static Future<Response<String>> addArticleUseful(
          {String id, String token}) async{
     Response<String> data =  await NetUtils.postX(API.addArticleUserful,
          data: {'id': id, 'token': token, 'isUseful': 'true'});
          print(data);
          return data;
          
          }
  static Future<Response<String>> getUsefulList(String id,
          {String page, String pageSize, String token}) async =>
      NetUtils.getX(API.getUserfulList, data: {
        'id': id,
        'token': token,
        'page': page,
        'PageSize': pageSize,
      });

  static Future<Response<String>> addComment(
          {String content, String pid, String refId, String token,String extJsonStr}) async =>
      NetUtils.postX(API.addComment, data: {
        'content': content,
        'pid': pid,
        'refId': refId,
        'token': token,
        'extJsonStr':extJsonStr,
        'type': '3'
      });
  static Future<Response<String>> getCommentList(
      {String page,
      String pageSize,
      String pid,
      String refId,
      String token}) async {
    Response<String> data = await NetUtils.postX(API.getCommentList, data: {
      'page': page,
      'PageSize': pageSize,
      'token': token,
      'refId': refId,
      'pid': pid,
    });
    return data;
  }
}
