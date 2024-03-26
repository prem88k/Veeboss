import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:veeboss/Models/Agent/ProfileData.dart';

import '../../Contants/Colors.dart';

class PdfView extends StatefulWidget {
  String resume;

  PdfView(this.resume);

  @override
  PdfViewState createState() => PdfViewState();
}

class PdfViewState extends State<PdfView> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;
  bool isLoading = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;

    }
    try {
      var uri = Uri.https(
        'yourang.shop',
        widget.resume.replaceAll("https://yourang.shop",""),
      );
      var data  = await http.get(uri);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }


  @override
  void initState() {
    getFileFromUrl('${widget.resume}',).then(
          (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    print(urlPDFPath);
    if (loaded) {
      return Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0,
          title: Text(
            "Resume",
            style: TextStyle(
                fontFamily: 'railway',
                color: appText,
                fontSize: size.height * 0.025,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: appBackground,
          iconTheme: IconThemeData(
              color: appText,
              size: size.height * 0.035 //change your color here
          ),
        ),
        body:
        urlPDFPath == null ? Container(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
              "No Resume Uploaded",
              style: TextStyle(
                  fontFamily: 'railway',
                  color: primaryColor,
                  fontSize: size.height * 0.023,
                  fontWeight: FontWeight.bold)
          ),
        ) : PDFView(
          filePath: urlPDFPath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          swipeHorizontal: true,
          nightMode: false,
          onError: (e) {
            //Show some error message or UI
          },
          onRender: (_pages) {
            setState(() {
              _totalPages = _pages!;
              pdfReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            setState(() {
              _pdfViewController = vc;
            });
          },
          onPageChanged: (int? page, int? total) {
            setState(() {
              _currentPage = page!;
            });
          },
          onPageError: (page, e) {},
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: 50,
              color: appButton,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              iconSize: 50,
              color:appButton,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            bottomOpacity: 0,
            elevation: 0,
            title: Text(
              "PDF Viewr",
              style: TextStyle(
                  fontFamily: 'railway',
                  color: whiteTextColor,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: buttonTextColor,
            iconTheme: IconThemeData(
                color: Colors.white,
                size: size.height * 0.035 //change your color here
            ),
          ),
          body: Text(
            "PDF Not Available",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
