import 'package:rate_flag/features/RateFlag/domain/model/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class LoadAllUser {
  final FirestoreRepository firestoreRepository;

  LoadAllUser(this.firestoreRepository);

  Future<List<User>> execute() {
    return firestoreRepository.getAllUsers();
  }
}
