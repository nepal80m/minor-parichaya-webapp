import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/expired_link';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fingerprint,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(Uri.base.toString()),
                    Text(
                      'Parichaya',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
              Text(
                'Sorry we couldn’t find any files to share.',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Text(
                'Please check if your share link is valid and try again.',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
