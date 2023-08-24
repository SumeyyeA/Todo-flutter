import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/provider/firebase_auth_provider.dart';

final getTodoProvider = FutureProvider((ref) async {
  final userId = ref.read(currentUserProvider)?.uid;
  final getData = await FirebaseFirestore.instance
      .collection("todos")
      .where("id", isEqualTo: userId)
      .get();

  return getData.docs;
});

final addTodoProvider =
    Provider.autoDispose.family((ref, TodoModel model) async {
  return await FirebaseFirestore.instance
      .collection("todos")
      .add(model.toJson());
});
final doneToggleProvider =
    Provider.autoDispose.family((ref, DoneToggleModel doneToggleModel) async {
  final firestore = FirebaseFirestore.instance;
  return await firestore
      .collection("todos")
      .doc(doneToggleModel.id)
      .update({"done": doneToggleModel.done});
});

class DoneToggleModel {
  final String id;
  final bool done;
  DoneToggleModel({required this.id, required this.done});
}
