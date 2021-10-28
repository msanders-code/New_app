import 'package:flutter/material.dart';
import '../model/photo.dart';

class PhotoCell extends StatelessWidget {
  final Photo photo;
  const PhotoCell({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: 'image${photo.id}',
                    child: FadeInImage.assetNetwork(
                      placeholder: 'images/noImage.jpg',
                      image: photo.thumbnailUrl,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
