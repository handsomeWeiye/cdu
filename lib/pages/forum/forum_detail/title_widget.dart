import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _title = Provider.of<ForumDetailsProvider>(context).articleDetail.data.title;
    return Container(
      child: Card(
        child: Container(padding: EdgeInsets.all(5),
        child: Text(_title,style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}