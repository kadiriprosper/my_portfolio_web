import 'package:cloud_firestore/cloud_firestore.dart';

enum AccessCondition {
  good,
  bad,
}

class DataModel {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<Map<AccessCondition, dynamic>> getData(
      {required String path, required String docId}) async {
    try {
      final doc = await firestoreInstance.collection(path).doc(docId).get();

      return {AccessCondition.good: doc.data()};
    } catch (_) {
      return {AccessCondition.bad: ''};
    }
  }

  Future<Map<AccessCondition, dynamic>> uploadData(
      {required String path,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await firestoreInstance.collection(path).doc().set(
            data,
          );

      return {AccessCondition.good: null};
    } catch (_) {
      return {AccessCondition.bad: ''};
    }
  }
}
