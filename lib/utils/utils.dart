export 'net_utils.dart';
export 'device_utils.dart';
export 'net_utils.dart';
export 'notification_utils.dart';
export 'package_utils.dart';
export 'shared_preference_utils.dart';
export 'theme_utils.dart';
export 'router_utils.dart';

    // CourseApi.getNewestCourse('201711533704','24351587uytr');
    // CourseApi.getCourse('201711533704','24351587uytr','2018-2019','1');
    // SchoolApi.getAllScore('201711533704','24351587uytr');
    // ScoreApi.getScore('201711533704','24351587uytr','2018-2019','1');
    // FestivalApi.getFestival();
    // GradeTestApi.getCetCode('12346','杜伟业');
    // GradeTestApi.getCetScore('12346','杜伟业','1234');
    // UserApi.register('18306832083', '2435', '24351587uytr');

    // UserApi.getSMS('18306832083');
    // UserApi.checkSms('1053','18306832083'); 
    // UserApi.register('18306832083', '5097', '24351587uytr');
        // UserApi.login('android','android1','18306832083','24351587uytr');
        // UserApi.updateUserDetail('1','1','1','1',token);
        // UserApi.getUserDetail(token:token);
        //  UserApi.sign(token:token);
          // UserApi.getSignList(token:token);
          //  UserApi.getTodaySign(token:token);
            // UserApi.getSignRules(token:token);

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   File _image;

//   Future getImage() async {
//     NetUtils.initConfig();
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     UserApi.uploadImage(image);
//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker Example'),
//       ),
//       body: Center(
//         child: _image == null
//             ? Text('No image selected.')
//             : Image.file(_image),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getImage,
//         tooltip: 'Pick Image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );

// }}



  void getData()async{
    String token = "40abed32-e2a3-4bc6-9691-3402b89ca5d3";


  }