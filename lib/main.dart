import 'package:flutter/material.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("jajs"),
      ),
      body: Image.network(
        'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){


        _onImageSaveButtonPressed();


      },

        child: Icon(Icons.file_download),

      ),
    );
  }


  void _onImageSaveButtonPressed() async {


    File _image;

 _onLoading(true);
    print("_onImageSaveButtonPressed");
    var response = await http
        .get('https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png');

    ///debugPrint(response.statusCode.toString());

    var filePath = await ImagePickerSaver.saveFile(
        fileData: response.bodyBytes);

    /*var savedFile= File.fromUri(Uri.file(filePath));
    print(savedFile.toString());*/
_onLoading(false);


// this may take time bz of downloading process

   print(filePath);
    String BASE64_IMAGE = filePath;

    final ByteData bytes = await rootBundle.load(BASE64_IMAGE);
    await EsysFlutterShare.shareImage('myImageTest.png', bytes, 'my image title');





  }

  // dialog indicates that image is dowanloaded

  void _onLoading( bool t) {


    if(t) {
      showDialog(
        context: context,

        barrierDismissible: false,
       builder: (BuildContext context){
          return SimpleDialog(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("Downding"),


            ],


          );






       }

      );
    }else {
      Navigator.pop(context);
    }
  }
}




