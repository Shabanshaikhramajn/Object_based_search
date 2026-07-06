import 'dart:io';

import 'package:flutter/material.dart';
import 'package:object_based_search/album_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

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
 List<Album> albums = [];
  loadAllAlbums()async{
  albums = await  PhotoGallery.listAlbums();
 albums.forEach((element) {
   print(element.name);
 });


  }



  @override
  Widget build(BuildContext context) {
    double imageWidth = (MediaQuery.of(context).size.width - 15)/3;
    return Scaffold(
       appBar: AppBar(title: Text("AI Gallery"),
        backgroundColor: Colors.red.shade50,
       ),
      body: Container(
        margin: EdgeInsets.only(left: 3,right: 3, top: 3),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
           mainAxisSpacing: 5, crossAxisSpacing: 3, childAspectRatio: .75
          ),
          itemBuilder: (BuildContext context, int index){
             Album album = albums[index];
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                   return AlbumPage(album);
                  }));
                },
                child: Column(
                  children: [
                    Container(
                      width: imageWidth,
                      child: FadeInImage(placeholder: MemoryImage(kTransparentImage), image: AlbumThumbnailProvider(album: album,
                       highQuality: true
                      ), fit: BoxFit.cover)
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(album.name.toString(), style: TextStyle(fontSize: 13),),

                    )

                  ],
                ),
              );
          },
          itemCount: albums.length,
        ),
      )
    );
  }
}
