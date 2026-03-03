import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/user.dart';

class LoadAllUser {
  final FirestoreRepository firestoreRepository;

  LoadAllUser(this.firestoreRepository);

  Future<List<User>> execute() {
    return firestoreRepository.getAllUsers();
  }
}
