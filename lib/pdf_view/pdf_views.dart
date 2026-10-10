import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViews extends StatelessWidget {
  const PdfViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 200,
        child: PDF(
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          backgroundColor: Colors.grey,
          onError: (error) {
            print(error.toString());
          },
        ).fromAsset('assets/pdfx/new_bar.pdf'),
      ),
    );
  }
}
