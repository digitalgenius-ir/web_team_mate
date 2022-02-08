import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget imageWidget(
  String image, {
  BoxFit fit = BoxFit.cover,
}) {
  return CachedNetworkImage(
    fit: fit,
    fadeInCurve: Curves.easeInCubic,
    filterQuality: FilterQuality.medium,
    fadeInDuration: const Duration(milliseconds: 200),
    imageUrl: image,
    placeholder: (context, url) => const CupertinoActivityIndicator(),
    errorWidget: (context, url, error) =>
        Center(child: Image.asset('assets/pic_profile.png', fit: BoxFit.cover)),
  );
}

CachedNetworkImageProvider imageProvider(String image) {
  return CachedNetworkImageProvider(image);
}
