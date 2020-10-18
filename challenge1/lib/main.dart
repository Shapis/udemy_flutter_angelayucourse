import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Center(child: Text("AYYYYY")),
        ),
        body: Center(
          child: Image(
            image: tryFetchImage(),
          ),
        ),
      ),
    ),
  );
}

NetworkImage tryFetchImage() {
  return NetworkImage('https://picsum.photos/400/600');
}
