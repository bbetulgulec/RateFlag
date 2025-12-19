import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

class FirebaseAuthImpl extends AuthRepository {
  final fb.FirebaseAuth auth = fb.FirebaseAuth.instance;

  @override
  Future<User> register(String email, String password) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await auth.setLanguageCode("tr");
    await credential.user!.sendEmailVerification();

    return User(
      uid: credential.user!.uid,
      firstName: "",
      lastName: "",
      mail: email,
      birthDate: DateTime.now(),
      password: password,
    );
  }

  @override
  Future<bool> checkEmailVerified() async {
    final fb.User? currentUser = auth.currentUser;
    if (currentUser == null) return false;

    await currentUser.reload();
    return currentUser.emailVerified;
  }

  @override
  Future<User?> login(String email, String password) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final fb.User fbUser = credential.user!;
    await fbUser.reload();

    if (!fbUser.emailVerified) {
      await auth.signOut();
      throw Exception("E-posta doğrulanmadı. Lütfen mailinizi kontrol edin.");
    }

    return User(
      uid: fbUser.uid,
      firstName: "",
      lastName: "",
      mail: fbUser.email ?? "",
      birthDate: DateTime.now(),
      password: "",
    );
  }

  @override
  Future<User?> getCurrentUser() async {
    final fb.User? fbUser = auth.currentUser;
    if (fbUser == null) return null;

    return User(
      uid: fbUser.uid,
      firstName: "",
      lastName: "",
      mail: fbUser.email ?? "",
      birthDate: DateTime.now(),
      password: "",
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> deleteAccount() async {
    await auth.currentUser!.delete();
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
