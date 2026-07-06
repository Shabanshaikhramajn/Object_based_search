import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GalleryHome(),
    );
  }
}

class GalleryHome extends StatefulWidget {
  const GalleryHome({super.key});

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadAllAlbums();
    requestPermissions();
  }

  requestPermissions()async{
   if(Platform.isIOS){
     if(await Permission.photos.request().isGranted || await Permission.storage.request().isGranted)
       {
         loadAllAlbums();
       }else if (Platform.isAndroid){
        if(await Permission.photos.request().isGranted || await Permission.storage.request().isGranted && await
         Permission.videos.request().isGranted) {
          loadAllAlbums();
        }
     }
   }
  }

  loadAllAlbums()async{
 List<Album> albums = await  PhotoGallery.listAlbums();
 albums.forEach((element) {
   print(element.name);
 });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
