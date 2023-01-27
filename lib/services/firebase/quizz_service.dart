import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:insurancehero/main.dart';
import 'package:insurancehero/models/paper_model.dart';

import '../../models/quiz_history_model.dart';
import '../../models/user_model.dart';
import '../../utils/firebase_instances.dart';

class QuizService {

    Future<List<QuizHistoryModel>> myQuizz() async {
      List<QuizHistoryModel> myList = [];
      try{
        QuerySnapshot snap = await FirebaseFirestore.instance.collection("history").where("uid",isEqualTo: userController.userModel.value.uid).orderBy("createdAt",descending: true).get();
         myList = snap.docs
            .map((e) => QuizHistoryModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        print(myList.length.toString() + "my Quiz numbers are");
      }catch(e){
                print(e.toString());
      }
      return myList;

    // questions = _data;
  }

  Future<List<PaperModel>> getPaper (String docId) async{
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("subjects")
        .doc(docId)
        .collection("papers")
        .get();

    List<PaperModel> myList = snap.docs
        .map((e) => PaperModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();

    print(myList.length.toString() + "<<<total papers are");
    return myList;
  }

    Future<List<dynamic>>  getMySubjects() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(userController.userModel.value.uid)
        .get();
    UserModel currentUser =
        UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  List<dynamic>  mySubjects = currentUser.categories ?? [];
  return mySubjects;
  }
}



addQuizzInHistort(QuizHistoryModel quizHistoryModel) {
  firebaseFirestore
      .collection("history")
      .add(quizHistoryModel.toMap())
      .then((value) => print("Quiz added to the history"));
}
