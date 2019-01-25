import 'package:flutter/material.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: dn(),
    );
  }



}
class dn extends StatefulWidget {
  @override
  _dnState createState() => _dnState();
}

  class _dnState extends State<dn> {
  String get = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    }
    var filePath;
  String BASE64_IMAGE ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("jajs"),
      ),
      body: Image.network(
        'https://www.w3schools.com/w3css/img_lights.jpg',
      ),
      persistentFooterButtons: <Widget>[
        FloatingActionButton(onPressed: (){
          _onImageWallpapButtonPressed();
        },
          child: Icon(Icons.wallpaper),
        ),
        FloatingActionButton(onPressed: (){
          _onImageShareButtonPressed();
          }, child: Icon(Icons.file_download),),
      ],
    );
  }

//share
  void _onImageShareButtonPressed() async {
    _onLoading(true);
    print("_onImageSaveButtonPressed");
    var response = await http.get('https://www.w3schools.com/w3css/img_lights.jpg');
    filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    print(filePath);
    BASE64_IMAGE = filePath;
    _onLoading(false);
    final ByteData bytes = await rootBundle.load(BASE64_IMAGE);
    await EsysFlutterShare.shareImage('myImageTest.png', bytes, 'my image title');
    }

//wallpaper
  void _onImageWallpapButtonPressed() async {
     _onLoading(true);
     print("_onImageSaveButtonPressed");
     var response = await http.get('https://www.w3schools.com/w3css/img_lights.jpg');
     filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

 _getWallpaper();
 }


//Dialog
  void _onLoading( bool t) {
    if(t) {
      showDialog(
        context: context,
          barrierDismissible: false,
       builder: (BuildContext context){
          return SimpleDialog(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("Downloading"),],
          );
          });
    }else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return SimpleDialog(
              children: <Widget>[

                new Text("Done..."),],
            );
          });

    }
  }


//platform specific


  static const platform = const MethodChannel('wallpaper');
  Future<void> _getWallpaper() async {
    try {
      final int result =  await platform.invokeMethod('getWallpaper',{"text":filePath});
       _onLoading(false);
    } on PlatformException catch (e) {
      Navigator.pop(context);

    }

  }
}




