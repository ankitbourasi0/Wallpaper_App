import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imageSource;
  final int index;
  final double extent; //height of the image
  const ImageTile(
      {super.key,
      required this.imageSource,
      required this.index,
      required this.extent});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      height: extent,
      child: Stack(fit: StackFit.expand, children: [
        CachedNetworkImage(imageUrl: imageSource, fit: BoxFit.cover),
        // Image.network(
        //   imageSource,
        //   fit: BoxFit.cover, //image fit cover the full area
        // ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.7),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    'Gello ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      //change icon to filled heart
                      //manage state
                    },
                    child: Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
