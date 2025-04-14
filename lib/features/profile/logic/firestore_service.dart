import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  final _users = FirebaseFirestore.instance.collection('users');

  /// ⬅️ حفظ بيانات المستخدم في Firestore
  Future<void> saveUserData(UserModel user) async {
    await _users.doc(user.uid).set(user.toMap());
  }

  /// ⬅️ جلب بيانات مستخدم واحد باستخدام UID
  Future<UserModel?> getUserData(String uid) async {
    final doc = await _users.doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  /// ⬅️ جلب كل المستخدمين (للـ Hunting)
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _users.get();
    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }
}
