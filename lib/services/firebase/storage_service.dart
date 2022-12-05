import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, File file) async {
    // creating location to our firebase storage
    String id = const Uuid().v1();
    Reference ref = _storage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putFile(
        file
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}