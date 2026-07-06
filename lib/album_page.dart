import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumPage extends StatefulWidget {
  Album album;

   AlbumPage(this.album);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMedia();
  }
  List<Medium> mediumList = [];
  loadMedia()async
  {
   MediaPage mediaPage =  await  widget.album.listMedia();
    mediumList = mediaPage.items;

    setState(() {
      mediumList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = (MediaQuery.of(context).size.width - 15)/3;

    return Scaffold(
        appBar: AppBar(title: Text(widget.album.name.toString()),
          backgroundColor: Colors.red.shade50,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 3,right: 3, top: 3),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                mainAxisSpacing: 5, crossAxisSpacing: 3, childAspectRatio: .75
            ),
            itemBuilder: (BuildContext context, int index){
              Medium medium = mediumList[index];
              return InkWell(
                onTap: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  //   return AlbumPage(album);
                  // }));
                },
                child: Column(
                  children: [
                    Container(
                        width: imageWidth,
                        child: FadeInImage(placeholder: MemoryImage(kTransparentImage), image:
                            ThumbnailProvider(mediumId: medium.id,
                            mediumType: medium.mediumType, highQuality: true,
                              ), fit : BoxFit.cover

                    ),
                    )

                  ],
                ),
              );
            },
            itemCount: mediumList.length,
          ),
        )
    );
  }
}
