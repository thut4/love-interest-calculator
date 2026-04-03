import 'package:image_picker/image_picker.dart';

abstract class PalmReadingRepository {
  Future<String> readPalm({required XFile image});
}
