import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/expired_link.dart';
import '../utils/server_url.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/document_details_tile.dart';
import '../utils/date_formatter.dart';

class ShareLinkDetails extends StatefulWidget {
  final String shareLinkId;
  final String encryptionKey;

  const ShareLinkDetails(
      {required this.shareLinkId, required this.encryptionKey, Key? key})
      : super(key: key);

  @override
  State<ShareLinkDetails> createState() => _ShareLinkDetailsState();
}

class _ShareLinkDetailsState extends State<ShareLinkDetails> {
  // static const routeName = '/share_link_details';
  // bool _isLoading = true;
  bool _isFetchingDocuments = false;
  String _fetchingDocumentMessage = 'Loading...';
  bool isInitialized = false;
  Map shareLinkData = {};
  String formattedExpiryDuration = '';

  Future<dynamic> getResponse(BuildContext context) async {
    setState(() {
      _isFetchingDocuments = true;
    });
    const baseUrl = baseServerUrl;
    final url = baseUrl + '${widget.shareLinkId}/${widget.encryptionKey}/';
    setState(() {
      _fetchingDocumentMessage = 'Sending request for your documents...';
    });
    final response = await http.get(
      Uri.parse(url),
    );
    setState(() {
      _fetchingDocumentMessage = 'Got your documents. Decrypting...';
    });
    if (response.statusCode != 200) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ExpiredLinkView(),
      ));
      setState(() {
        _fetchingDocumentMessage = 'Loading...';
        _isFetchingDocuments = false;
      });
      return;
    }
    setState(() {
      _fetchingDocumentMessage = 'Got your documents. Decrypting...';
    });

    setState(() {
      shareLinkData = json.decode(response.body);
      _isFetchingDocuments = false;

      // _isLoading = false;
    });

    final expiryDate = DateTime.parse(shareLinkData['expiry_date']);
    formattedExpiryDuration = getFormattedExpiry(expiryDate);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getResponse();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      getResponse(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isFetchingDocuments
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(_fetchingDocumentMessage),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 300),
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
                          Container(
                            width: 350,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Parichaya',
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            ),
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
                      formattedExpiryDuration.isEmpty
                          ? 'Link Has Expired'
                          : 'Expires in $formattedExpiryDuration',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            launch(
                                '$baseServerUrl/${shareLinkData['id']}/images/${widget.encryptionKey}/download/');
                          },
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.amber,
                          highlightColor: Colors.deepOrange,
                          child: Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Download All Files',
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
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
                    if (shareLinkData.isNotEmpty)
                      SharedDocumentDetailsTiles(
                        documents: shareLinkData['documents'],
                        encryptionKey: widget.encryptionKey,
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
