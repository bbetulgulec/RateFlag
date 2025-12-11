import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

class FirebaseAuthImpl extends AuthRepository {
  final fb.FirebaseAuth auth = fb.FirebaseAuth.instance;

  @override
  Future<User> register(
    String firstName,
    String lastName,
    String mail,
    DateTime birthDate,
    String password,
  ) async {
    // Firebase Auth ile kullanıcı oluştur
    final credential = await auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );
    await auth.setLanguageCode("tr");

    // E-mail doğrulama maili gönder
    await credential.user!.sendEmailVerification();

    // Domain User nesnesi dön
    return User(
      uid: credential.user!.uid,
      firstName: firstName,
      lastName: lastName,
      mail: mail,
      birthDate: birthDate,
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
  Future<void> deleteAccount() async {
    await auth.currentUser!.delete();
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
