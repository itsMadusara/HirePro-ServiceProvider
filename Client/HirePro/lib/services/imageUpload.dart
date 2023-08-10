import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';


class ImageUpload {
  ImageUpload({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  bool multiple = false;

  pickImage(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(source: source);
      if (file != null) {
        return file;
      }
      return;
    } catch (e) {
      print(e);
    }
  }

  Future<List<XFile>> pickImageMultiple() async {
    return await _imagePicker.pickMultiImage();
  }

  Future<CroppedFile?> crop(
      {required XFile file, CropStyle cropStyle = CropStyle.rectangle}) async {
    final croppedFile = await _imageCropper.cropImage(
        sourcePath: file.path, cropStyle: cropStyle, compressQuality: 100);
    return croppedFile;
  }
}
