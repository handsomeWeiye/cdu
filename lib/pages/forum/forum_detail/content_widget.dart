import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _content = Provider.of<ForumDetailsProvider>(context).articleDetail.data.content;
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Html(data: _content,),
        ),
      ),
    );
  }
}