
import 'package:dio/dio.dart';
import 'package:cdu_helper/utils/utils.dart';
import 'api.dart';

Future<Response<String>>  response ;

class CmsApi{
  static  Future<Response<String>> getCmsCategories({String id,String token})async=> NetUtils.getX(API.getCmsCategories,data: {'id':id,'token':token});
  static  Future<Response<String>> getCmsCategoryList({String token})async=> NetUtils.getX(API.getCmsCategoryList,data: {'token':token});


  static  Future<Response<String>> getArticleList({String categoryId,String keywordsLike,String page,String token,String titleLike})async=> NetUtils.postX(API.getArticleList,data: {'categoryId':categoryId,'keywordsLike':keywordsLike,'page':page,'token':token,'titleLike':titleLike});
  static  Future<Response<String>> addArticle(String categoryId,String title,String descript,String content,String token,{String author,String id,String pic,String keywords,})async {
      NetUtils.postX(API.addArticle,data: {'content':content,'author':author,'token':token,'categoryId':categoryId,'title':title,'descript':descript,'id':id,'pic':pic,'keywords':keywords});
  }
  static  Future<Response<String>> getArticle(String id,{String token})async=> NetUtils.getX(API.getArticle,data: {'id':id,'token':token});
  static  Future<Response<String>> getPreNextArticle(String id,{String token})async=> NetUtils.getX(API.getPreNextArticle,data: {'id':id,'token':token});
  static  Future<Response<String>> deleteArticle(String id,{String token})async=> NetUtils.postX(API.deleteArticle,data: {'id':id,'token':token});



  static  Future<Response<String>> getFavList({String page,String pageSize,String titleLike,String token})async=>NetUtils.postX(API.getFavList,data: {'page':page,'pageSize':pageSize,'titleLike':titleLike,'token':token});
  static  Future<Response<String>> addFav(String id,{String token})async=>NetUtils.postX(API.addFav,data: {'id':id,'token':token});
  static  Future<Response<String>> checkFav({String id,String token})async=>NetUtils.getX(API.checkFav,data: {'id':id,'token':token});
  static  Future<Response<String>> deleteFav({String id,String newsId,String token})async=>NetUtils.postX(API.deleteFav,data: {'id':id,'newsId':newsId,'token':token});


  static  Future<Response<String>> addArticleUseful(String id,{String token})async=>NetUtils.postX(API.addArticleUserful,data: {'id':id,'token':token,'isUseful':'true'});
  static  Future<Response<String>> getUsefulList(String id,{String page,String pageSize,String token})async=>NetUtils.getX(API.getUserfulList,data: {'id':id,'token':token,'page':page,'PageSize':pageSize,});

  static  Future<Response<String>> addComment({String content,String pid,String refld,String token})async=>NetUtils.postX(API.addComment,data: {'content':content,'pid':pid,'refld':refld,'token':token,'type':'3'});
  static  Future<Response<String>> getCommentList({String page,String pageSize,String pid,String refld,String token})async=>NetUtils.postX(API.getCommentList,data: {'page':page,'PageSize':pageSize,'token':token,'refld':refld,'pid':pid,});
}