import 'package:cdu_helper/constants/constants.dart';
import 'package:flutter/material.dart';
import 'time_bar_widget.dart';
import 'swiper_widget.dart';
import 'category_grid_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('主页'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              swiperWideget(),
              timeBarWidget(),
              categoryGridWidget(SpUtils.getTokenSync()),
            ],
          ),
        )
        );
  }
}

