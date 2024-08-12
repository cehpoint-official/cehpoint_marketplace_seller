import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:image/image.dart' as img;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Initialize the camera controller
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }

  Future<void> _takePhoto() async {
    try {
      await _initializeControllerFuture;

      final XFile picture = await _controller.takePicture();
      File capturedImage = File(picture.path);

      // Navigate to DisplayCapturedImage page
      File? result = await Get.to<File>(
        () => DisplayCapturedImage(image: capturedImage),
      );

      // This code block will be executed when returning from DisplayCapturedImage
      if (result != null) {
        // Do something with the returned file (if needed)
        Get.back(result: result);
        if (kDebugMode) {
          print('Selected Image: ${result.path}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error taking photo: $e');
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: const PlainText(
          name: "Take Image",
          fontsize: 20,
          color: Colors.white,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the camera preview
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Expanded(
            child: Center(
              child: IconButton(
                  onPressed: _takePhoto,
                  iconSize: 60,
                  color: const Color(0xFF08215E),
                  icon: const Icon(Icons.camera)),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DisplayCapturedImage extends StatefulWidget {
  late File image;

  DisplayCapturedImage({super.key, required this.image});

  @override
  State<DisplayCapturedImage> createState() => _DisplayCapturedImageState();
}

class _DisplayCapturedImageState extends State<DisplayCapturedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: const PlainText(
          name: "Edit Image",
          fontsize: 20,
          color: Colors.white,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 5,
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                height: MediaQuery.sizeOf(context).width * 0.6,
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: Image.file(widget.image),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () async {
                        File? rotatedImage =
                            await rotateImage(widget.image, clockwise: true);
                        setState(() {
                          widget.image = rotatedImage!;
                        });
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.rotate_90_degrees_cw,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Rotate",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        Get.back(result: null);
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flip_camera_ios_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Retake",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(5),
              child: RoundedButton(
                  title: "Save",
                  textColor: Colors.white,
                  fontsize: 15,
                  radius: 0,
                  borderColor: Colors.transparent,
                  buttonColor: const Color.fromRGBO(15, 98, 223, 1),
                  onTap: () {
                    Get.back(result: widget.image);
                  }),
            )),
          ),
        ],
      ),
    );
  }

  Future<File?> rotateImage(File file, {bool clockwise = true}) async {
    try {
      final Uint8List bytes = await file.readAsBytes();
      img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

      // Rotate the image
      if (clockwise) {
        image = img.copyRotate(image, angle: 90);
      } else {
        image = img.copyRotate(image, angle: -90);
      }

      // Save the rotated image to a new file
      final rotatedFile = File(
          '${file.path.substring(0, file.path.lastIndexOf("."))}_rotated.jpg');
      await rotatedFile.writeAsBytes(img.encodeJpg(image));

      return rotatedFile;
    } catch (e) {
      debugPrint('Error rotating image: $e');
      return null;
    }
  }
}
