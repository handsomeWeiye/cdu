import 'dart:core';
export 'school_api.dart';
export 'user_api.dart';
export 'cms_api.dart';

class API {
  static const String apifmBaseUrl = 'https://api.it120.cc/';
  static const String apifmAdminBaseUrl = 'https://user.api.it120.cc/';
  static const String schoolApiBaseUrl = 'http://schoolapi.weiye.site/';
  static const String bmobApiBaseUrl = 'https://api2.bmob.cn/1/classes/';
  static const String domain = 'cdu'; //api工厂专属域名

  static final String homePage = "http://cdu.weiye.site"; //应用官网

  //系统相关
  static final String uploadFiles = apifmBaseUrl + domain + '/dfs/upload/file';//文件上传
  static final String getFirstDayOfTerm = apifmBaseUrl + domain + '/config/value'; //获取学期初始日期
  static final String getLatestVersion = apifmBaseUrl + domain + '/config/value'; //获取最新版本号
  static final String getLatestAndroid =  apifmBaseUrl + domain + '/config/value'; //获取最新安卓安装包
  static final String getLatestIOS =  apifmBaseUrl + domain + '/config/value'; //获取最新IOS安装包
  static final String getAnnouncement = apifmBaseUrl + domain + '/config/value'; //获取版本更新公告

  //短信相关
  static final String getSms = apifmBaseUrl + domain +'/verification/sms/get'; //获取验证码
  static final String checkSms = apifmBaseUrl + domain +'/verification/sms/check'; //校验验证码

  /// 教务系统相关
  static final String getCourseSchedule = schoolApiBaseUrl +'schedule'; //获取课表数据
  static final String getScore = schoolApiBaseUrl +'score'; //获取成绩数据
  static final String getFestivalList = bmobApiBaseUrl + 'thingDate?order=thingDate'; //获取学校日期
  /// 等级考试相关
  static final String getCetCode = "https://www.yyqblog.com/api/v1/cet/captcha"; //获取四六级验证码
  static final String getCetScore = "https://www.yyqblog.com/api/v1/cet/query"; //获取四六级成绩

  /// 用户相关
  static final String register = apifmBaseUrl + domain +'/user/m/register'; //手机号注册
  static final String login = apifmBaseUrl + domain +'/user/m/login'; //手机号登录
  static final String loginAdmin = apifmAdminBaseUrl +'login/key'; //登录管理后台
  static final String loginOut = apifmBaseUrl + domain +'/user/loginout'; //退出登录
  static final String resetPwd = apifmBaseUrl + domain +'/user/m/reset-pwd'; //修改密码

  static final String getUserInfo = schoolApiBaseUrl +'userInfo'; //获取教务系统用户信息
  static final String getUserDetail = apifmBaseUrl + domain +'/user/detail'; //获取用户详情
  // static final String othersDetail =apifmBaseUrl + domain + '/user/friend/detail';
  static final String updateUserDetail = apifmBaseUrl + domain +'/user/modify'; //修改用户详情

  static final String sign = apifmBaseUrl + domain + '/score/sign'; //签到
  static final String getSignList = apifmBaseUrl + domain + '/score/sign/logs'; //获取所有签到记录
  static final String getTodaySign = apifmBaseUrl + domain + '/score/today-signed'; //获取今日签到记录
  static final String getSignRules = apifmBaseUrl + domain + '/score/sign/rules'; //获取签到积分规则

  /// 社交相关
  //使用Jmessage系统来完成社交系统构建,SocialApi 即 JmessageApi
  static final String addFollow = apifmBaseUrl + domain + '/user/friend/add'; //关注某用户
  static final String getFollowList = apifmBaseUrl + domain + '/user/friend/list'; //获取关注用户列表

  /// 收货地址相关
  static final String addAddress = apifmBaseUrl + domain + '/user/shipping-address/add';  //添加收货地址
  static final String getNewestAddress = apifmBaseUrl + domain + '/user/shipping-address/default/v2'; //获取最新收货地址
  static final String getAddressDetail = apifmBaseUrl + domain + '/user/shipping-address/detail/v2'; //获取收货地址详情
  static final String getAllAddress = apifmBaseUrl + domain + '/user/shipping-address/list';   //获取收货地址列表
  static final String updateAddress = apifmBaseUrl + domain + '/user/shipping-address/update';  //更新收货地址
  static final String deleteAddress = apifmBaseUrl + domain + '/user/shipping-address/delete';  //删除收货地址

  /// 论坛相关
  static final String getCmsCategories = apifmBaseUrl + domain + '/cms/category/info'; //获取文章分类
  static final String getCmsCategoryList  = apifmBaseUrl + domain + '/cms/category/list'; //获取文章分类列表

  static final String getArticleList  = apifmBaseUrl + domain + '/cms/news/list'; //获取文章列表
  static final String addArticle  = apifmBaseUrl + domain + '/cms/news/put'; //添加修改文章
  static final String getArticle  = apifmBaseUrl + domain + '/cms/news/detail'; //获取文章
  static final String getPreNextArticle  = apifmBaseUrl + domain + '/cms/news/preNext'; //获取上一篇下一篇文章
  static final String deleteArticle  = apifmBaseUrl + domain + '/cms/news/del'; //删除文章

  static final String getFavList = apifmBaseUrl + domain + '/cms/news/fav/list'; //获取文章收藏列表
  static final String addFav = apifmBaseUrl + domain + '/cms/news/fav/add'; //添加文章收藏
  static final String checkFav = apifmBaseUrl + domain + '/cms/news/fav/check'; //检测文章收藏
  static final String deleteFav = apifmBaseUrl + domain + '/cms/news/fav/delete'; //删除文章收藏

  static final String addArticleUserful =  apifmBaseUrl + domain + '/cms/news/useful';  //添加检测文章赞与踩
  static final String getUserfulList =  apifmBaseUrl + domain + '/cms/news/useful/logs';  //获取文章点赞记录

  static final String addComment = apifmBaseUrl + domain + '/comment/add'; //添加评论
  static final String getCommentList = apifmBaseUrl + domain + '/comment/list'; //读取评论列表

  //失物招领相关
  static final String addLost = bmobApiBaseUrl + 'lost';//添加失物
  static final String getLostList = bmobApiBaseUrl + 'lost';//获取失物列表
  static final String updateLost = bmobApiBaseUrl + 'lost/';//修改失物信息
  static final String getLost = bmobApiBaseUrl +'lost/';//获取失物详情
  static final String deleteLost = bmobApiBaseUrl + 'lost/';//删除失物信息

  ///商品相关
  static final String getCategoryList = apifmBaseUrl + domain + '/shop/goods/category/all'; //获取商品分类列表
  static final String getGoodsList = apifmBaseUrl + domain + '/shop/goods/list'; //获取商品列表  
  static final String getGoodsDetail = apifmBaseUrl + domain + '/shop/goods/detail'; //获取商品详情
  static final String getGoodsPrice = apifmBaseUrl + domain + '/shop/goods/price'; //获取商品实时价格
  static final String getGoodsComment = apifmBaseUrl + domain + '/shop/goods/reputation'; //获取商品评价


  static final String addGoodsFav = apifmBaseUrl + domain + '/shop/goods/fav/add'; //添加商品收藏
  static final String checkGoodsFav = apifmBaseUrl + domain + '/shop/goods/fav/check'; //检测是否收藏
  static final String deleteGoodsFav = apifmBaseUrl + domain + '/shop/goods/fav/delete'; //删除商品收藏
  static final String getGoodsFavList = apifmBaseUrl + domain + '/shop/goods/fav/list'; //获取商品收藏列表

  ///购物车相关
  static final String addCart = apifmBaseUrl + domain + '/shopping-cart/add'; //加入购物车
  static final String getCartList = apifmBaseUrl + domain + '/shopping-cart/info'; //获取购物车数据
  static final String updateCart = apifmBaseUrl + domain + '/shopping-cart/modifyNumber'; //修改购物车数据
  static final String deleteCart = apifmBaseUrl + domain + '/shopping-cart/remove'; //删除某条购物车数据
  static final String cleanCart = apifmBaseUrl + domain + '/shopping-cart/empty'; //清空购物车数据

  ///订单相关
  static final String addOrder  = apifmBaseUrl + domain + '/order/create';//创建订单
  static final String getOrederStatistics = apifmBaseUrl + domain + '/order/statistics';//获取订单统计
  static final String getOrderList = apifmBaseUrl + domain + '/order/list';//获取订单列表
  static final String getOrderDetail = apifmBaseUrl + domain + '/order/detail';//获取订单详情
  static final String deliveryOrder = apifmBaseUrl + domain + '/order/delivery';//确认收货
  static final String closeOrder = apifmBaseUrl + domain + '/order/close';//关闭订单
  static final String deleteOrder = apifmBaseUrl + domain + '/order/delete';//删除订单
  static final String payOrder = apifmBaseUrl + domain +'/order/pay'; //支付订单
  static final String reputionOrder = apifmBaseUrl + domain +'/order/reputation';//评价订单

  static final String addRefund = apifmBaseUrl + domain +'/order/refundApply/apply';//添加订单售后
  static final String getRefundDetail = apifmBaseUrl + domain +'/order/refundApply/info';//获取售后详情
  static final String deleteRefund = apifmBaseUrl + domain + '/order/refundApply/cancel';//撤销售后申请
  static final String getRefundList = apifmBaseUrl + domain +'/order/refund';//获取售后订单列表
  ///支付相关
  static final String aliPay = apifmBaseUrl + domain +'/pay/alipay/gate/app';//拉起支付宝支付
  static final String getPayStatistics = apifmBaseUrl +domain +'/pay/query';//获取支付状态

  ///优惠券相关
  static final String getCouponsList = apifmBaseUrl + domain + '/discounts/coupons';//获取可领取优惠券列表
  static final String addCoupons = apifmBaseUrl + domain + '/discounts/fetch';//添加优惠券
  static final String getMyCoupons = apifmBaseUrl + domain +'/discounts/my';//获取我的优惠券
  static final String getCouponsDetails = apifmBaseUrl + domain + '/discounts/detail'; //获取优惠券详情





}