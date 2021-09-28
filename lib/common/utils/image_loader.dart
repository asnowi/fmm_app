import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageLoader {
  static Widget load({required String url, double? width, double? height, Alignment? alignment, BoxFit? fit}){
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      alignment: alignment?? Alignment.center,
      placeholder: (context, url) => const CupertinoActivityIndicator(radius: 5,),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: fit?? BoxFit.cover,
    );
  }
}