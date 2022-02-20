import 'package:flutter/material.dart';
import 'package:parichaya_web/views/expired_link_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fingerprint,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      'Parichaya',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                'We have some files for you.',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Text(
                'Expires in 2 days and 4 hours.',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ExpiredViewLink.routeName);
                    },
                    child: Container(
                      height: 50,
                      width: 210,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Download All Files',
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            const Icon(
                              Icons.download,
                              size: 28,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // ...shareLink.documents.map(
              //   (document) {
              //     return SharedDocumentDetailsTile(
              //       title: document.title,
              //       images: document.images,
              //       onTap: () {},
              //     );
              //   },
              // ).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
