import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExploreTab extends StatefulWidget {

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {

  List<String> images = ["https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg",
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg"];

  List<String> likes = ["248 likes", "100 likes", "20 likes", "500 likes", "444 likes"];

  List<String> description = ["A very shiny and awesome chair",
    "My Cupboard",
    "This is Love",
    "OMG, Awesome",
    "No Caption"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: AppBar(
        leading: Container(),
        elevation: 0.0,
        backgroundColor: Color(0xff333333),
        title: Text("Explore", style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {}),
          IconButton(icon: Icon(Icons.add, color: Colors.white,), onPressed: () {}),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Image.network(images[index], width: 270.0,),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        Text(likes[index], textAlign: TextAlign.justify, style: TextStyle(
                            color: Colors.white, fontSize: 18.0
                        ),),
                        SizedBox(
                          width: 70.0,
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.heart, color: Colors.white,), onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.comment, color: Colors.white,), onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.share, color: Colors.white,), onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(description[index], textAlign: TextAlign.justify, style: TextStyle(
                      color: Colors.white, fontSize: 18.0
                  ),),
                ],
              );
            },
          )),
    );
  }
}
