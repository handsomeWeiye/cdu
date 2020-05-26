import 'package:cdu_helper/apis/systerm_api.dart';
import 'package:cdu_helper/beans/banner.dart' as bean;
import 'package:cdu_helper/constants/configs.dart';
import 'package:cdu_helper/utils/data_utils.dart';
import 'package:cdu_helper/widgets/loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget swiperWideget() {
  return Container(
    child: Card(
      margin: EdgeInsets.all(5),
      child: FutureBuilder(
        future: SystermApi.getBanner(type: Configs.appTitle),
        builder:
            (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //json序列化
            Map<String, dynamic> data = DataUtils.snapToData(snapshot.data);
            //json对象化
            bean.Banner banner = bean.Banner.fromJson(data);
            List<bean.Data> swiperList = banner.data;
            return Container(
                width: ScreenUtil.screenWidth,
                height: 150,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      swiperList[index].picUrl,
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: swiperList.length,
                  viewportFraction: 0.8,
                  scale: 0.8,
                  autoplay: true,
                  autoplayDisableOnInteraction: false,
                  autoplayDelay: 3000,
                ));
          }
        },
      ),
    ),
  );
}
