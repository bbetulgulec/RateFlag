import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class GetSavedPosts {
  final FirestoreRepository firestoreRepository;

  GetSavedPosts(this.firestoreRepository);

  Future<List<String>> execute({required String userId}) async {
    return await firestoreRepository.getSavedPosts(userId: userId);
  }
}
