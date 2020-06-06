import 'package:cdu_helper/beans/article_detail.dart';
import 'package:cdu_helper/providers/forum_provider.dart';
import 'package:cdu_helper/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ExtInfo _authorInfo = Provider.of<ForumDetailsProvider>(context).authorInfo;
    var _authorPic = _authorInfo.authorPic;
    var _authorName = _authorInfo.authorName;
    return Card(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(_authorPic),
                ),
                Text(
                  _authorName,
                  style: TextStyle(fontSize:30),
                )
              ],
            ),
          ),
        );
  }
}


// Consumer<ForumDetailsProvider>(
//       builder: (context, ForumDetailsProvider forumDetails, _) {
//         return Card(
//           child: Container(
//             padding: EdgeInsets.all(5),
//             child: Row(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage:
//                       NetworkImage(forumDetails.authorInfo.authorPic),
//                 ),
//                 Text(
//                   forumDetails.authorInfo.authorName,
//                   style: TextStyle(fontSize: 30),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
