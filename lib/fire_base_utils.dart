

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseUtils {
  

static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('user').withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.formjson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.tojson(),
          );




  static CollectionReference<TaskModel> getTasksCollection(String userid) =>
  getUserCollection().doc(userid).collection('task').withConverter<TaskModel>(
            fromFirestore: (snapshot, options) =>
                TaskModel.formjson(snapshot.data()!),
            toFirestore: (TaskModel, options) => TaskModel.tojson(),
          );

  static Future<void> addTaskToFireStore(TaskModel taskModel,String userId) {
    final taskCollection = getTasksCollection(userId);
    final doc = taskCollection.doc();
    taskModel.id = doc.id;

    return doc.set(taskModel);
  }

  static Future<List<TaskModel>> getAllTasksFromFireStore(String userId) async {
    final taskCollection = getTasksCollection(userId);
    final querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deletetaskFromFireStore(String id,String userId) {
    final taskCollection = getTasksCollection(userId);
    return taskCollection.doc(id).delete();
  }

  static Future<UserModel> register(
      {required String password,
      required String email,
      required String name}) async {
    var credential;
    try{
       credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password,);
        
    }
    catch(e){print('the value of e is ////////////////////////////////////////////////  $e');}
   final user= UserModel(name: name, email: email, id: credential.user!.uid);
    final userCollection=getUserCollection();
    await  userCollection.doc(user.id).set(user);
    
    return user;

  }

  static Future <UserModel> login(String email, String password) async{
    final credential=await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    final userCollection=getUserCollection();
   final docSnapshot=await  userCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }
  static void logout() {}
}
