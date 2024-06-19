 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

boxtile(String title) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      // height: 30,
      decoration: BoxDecoration(color: Colors.white, border: Border.all()),
      child: Text(title),
    );
  }