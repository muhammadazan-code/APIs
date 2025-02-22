import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  /* First we need path of image so for this I  write here getImagePath function but it will be in future. */
  File? pathOfImage;
  final ImagePicker _pickerOfImage = ImagePicker();
  Future getImagePath() async {
    final image = await _pickerOfImage.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      pathOfImage = File(image.path.toString());
    } else {
      print("We cannot get path of the image");
    }
  }

/* Here I write a fuction that will load the image. */
  Future<void> loadImage() async {
    var streamOfImage = http.ByteStream(pathOfImage!.openRead());
    var imageLength = await pathOfImage!.length();
    streamOfImage.cast();
    var url = Uri.parse('https://fakestoreapi.com/products');
    var sendingRequestToServer = http.MultipartRequest('POST', url);
    sendingRequestToServer.fields['title'] = 'Static title';
    var mp = http.MultipartFile('images', streamOfImage, imageLength);
    sendingRequestToServer.files.add(mp);
    var response = await sendingRequestToServer.send();
    if (response.statusCode == 200) {
      print('Image is uploaded');
    } else {
      print('No image is  uploaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              GestureDetector(
                onTap: () {
                  getImagePath();
                  setState(() {});
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: pathOfImage == null
                      ? Center(
                          child: Text(
                            'Pick image',
                            style: TextStyle(fontSize: 30),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            border: Border.all(
                              // width: 3.0,
                              color: Colors.orange,
                            ),
                          ),
                          child: Image.file(
                            File(pathOfImage!.path).absolute,
                            height: 180,
                            width: 180,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(30),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.blueAccent,
              ),
              foregroundColor: WidgetStatePropertyAll(
                Colors.white,
              ),
            ),
            onPressed: () {
              loadImage();
              setState(() {});
            },
            child: Center(
              child: Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
