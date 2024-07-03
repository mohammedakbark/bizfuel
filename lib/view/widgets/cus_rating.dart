import 'dart:developer';

import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CustomRating extends StatelessWidget {
  double initalRating;
  bool isConst;
  double? size;
  CustomRating(
      {super.key,
      required this.initalRating,
      required this.isConst,
      this.size});

  @override
  Widget build(BuildContext context) {
    log(initalRating.toString());
    log("message");
    return RatingBar.builder(
        initialRating: initalRating,
        itemSize: size ?? 20,
        unratedColor: Colors.grey,
        ignoreGestures: isConst,
        itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (index) {
          Provider.of<FirebaseHelper>(context, listen: false)
              .updateRating(index);
        });
  }

  static double ratings(rating) {
    switch (rating) {
      case > 0 && <= 20:
        {
          return 1.0;
        }
      case > 20 && <= 40:
        {
          return 2.0;
        }
      case > 40 && <= 60:
        {
          return 3.0;
        }
      case > 60 && <= 80:
        {
          return 4.0;
        }
      case > 80:
        {
          return 5.0;
        }
      default:
        {
          return 0.0;
        }
    }
  }
}
