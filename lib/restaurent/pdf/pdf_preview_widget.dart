import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class PdfPreviewWidget extends StatefulWidget {
  final String pdfPath;
  final String pdfName;

  const PdfPreviewWidget(
      {super.key, required this.pdfPath, required this.pdfName});

  @override
  _PdfPreviewWidgetState createState() => _PdfPreviewWidgetState();
}

class _PdfPreviewWidgetState extends State<PdfPreviewWidget> {
  Uint8List? imageBytes;
  int totalPages = 0;

  /// A static cache to store rendered thumbnail images.
  static final Map<String, Uint8List> _thumbnailCache = {};

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      // If we have cached the rendered thumbnail, use it.
      if (_thumbnailCache.containsKey(widget.pdfPath)) {
        setState(() {
          imageBytes = _thumbnailCache[widget.pdfPath];
          // (Optionally, you could also cache and restore the total pages.)
        });
        return;
      }

      // Get a temporary directory.
      final tempDir = await getTemporaryDirectory();
      // Use the asset file name as the cache key.
      final fileName = widget.pdfPath.split('/').last;
      final tempFile = File('${tempDir.path}/$fileName');

      // If the temporary file doesn't exist, load from assets and write it.
      if (!await tempFile.exists()) {
        final byteData = await rootBundle.load(widget.pdfPath);
        final bytes = byteData.buffer.asUint8List();
        await tempFile.writeAsBytes(bytes);
      }

      // Open the PDF document from the temporary file.
      final doc = await PdfDocument.openFile(tempFile.path);

      // Get the total number of pages.
      setState(() {
        totalPages = doc.pagesCount;
      });

      // Render the first page as a PNG image.
      final page = await doc.getPage(1);
      final pageImage = await page.render(
        width: page.width,
        height: page.height,
        format: PdfPageImageFormat.png,
      );
      await page.close();

      // Save the rendered bytes in our cache.
      if (pageImage?.bytes != null) {
        _thumbnailCache[widget.pdfPath] = pageImage!.bytes;
      }

      setState(() {
        imageBytes = pageImage?.bytes;
      });

      await doc.close();
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // PDF thumbnail preview with increased height.
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.memory(
                  imageBytes!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 8),
              // Display total pages count.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.pdfName.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Colors.white),
                  ),
                  Text(
                    " - $totalPages pages".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
