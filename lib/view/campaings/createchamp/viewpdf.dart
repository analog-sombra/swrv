import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/utilthemes.dart';

class PdfLocalViewer extends HookConsumerWidget {
  final File file;
  const PdfLocalViewer({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isLoading = useState(true);
    PdfViewerController controller = PdfViewerController();
    useEffect(() {
      Timer(const Duration(seconds: 10), () {
        isLoading.value = false;
      });
      return null;
    });
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundC,
      appBar: AppBar(
        backgroundColor: secondaryC,
        title: const Text(
          "SWRV PDF Viwer",
          textScaleFactor: 1,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: (isLoading.value)
                      ? const Center(child: CircularProgressIndicator())
                      : SfPdfViewer.file(
                          controller: controller,
                          file,
                          pageLayoutMode: PdfPageLayoutMode.single,
                        ),
                ),
              ),
              if (!isLoading.value) ...[
                Positioned(
                  left: 0,
                  bottom: height * 0.025,
                  child: SizedBox(
                    width: width,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryC),
                              onPressed: () {
                                controller.previousPage();
                              },
                              child: const Text("Previous")),
                        )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryC,
                                ),
                                onPressed: () {
                                  controller.nextPage();
                                },
                                child: const Text("Next")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
