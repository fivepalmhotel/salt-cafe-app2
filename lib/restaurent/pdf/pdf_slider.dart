import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pdf_preview_widget.dart';
import 'pdf_view_screen.dart'; // Import the PDF view screen (created below)

class PdfHorizontalListView extends StatefulWidget {
  const PdfHorizontalListView({
    super.key,
    required this.location,
  });

  final String location;

  @override
  State<PdfHorizontalListView> createState() => _PdfHorizontalListViewState();
}

class _PdfHorizontalListViewState extends State<PdfHorizontalListView> {
  final List<String> pdfPaths = [
    // 'assets/pdfx/new_bar.pdf',
    // 'assets/pdfx/food_menu.pdf',
    // 'assets/pdfx/delhi_menu.pdf',
    // 'assets/pdfx/noida_menu.pdf',
    // 'assets/pdfx/agra_menu.pdf',
  ];

  final List<String> pdfNames = [
    // 'New Bar',
    // 'Food Menu',
    // 'Delhi Menu',
    // 'Noida Menu',
    // 'Agra Menu'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.location.contains("Noida")) {
      pdfPaths.add("assets/pdfx/noida_menu.pdf");
      pdfNames.add("Noida Menu");
    } else if (widget.location.contains("Delhi")) {
      pdfPaths.add("assets/pdfx/delhi_menu.pdf");
      pdfNames.add("Delhi Menu");
    } else if (widget.location.contains("Agra")) {
      pdfPaths.add("assets/pdfx/agra_menu.pdf");
      pdfNames.add("Agra Menu");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set the background color if needed
      body: Padding(
        padding: EdgeInsets.all(8.0.w), // Adjust padding to your design
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Set horizontal scrolling
          itemCount: pdfPaths.length,
          itemBuilder: (BuildContext context, int index) {
            print("Testing ${pdfPaths[index]} ${pdfNames[index]}");
            return GestureDetector(
              onTap: () {
                // Navigate to full PDF view on tap
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => PdfViewScreen(pdfPath: pdfPaths[index]),
                    fullscreenDialog:
                        true, // Optional: gives a full-screen modal feel.
                  ),
                );
              },
              child: Container(
                width: 200.w,
                margin: EdgeInsets.only(right: 10.w), // Spacing between items
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      blurRadius: 8.0, // Shadow blur radius
                      offset: const Offset(0, 4), // Shadow offset
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PdfPreviewWidget(
                      pdfPath: pdfPaths[index], pdfName: pdfNames[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
