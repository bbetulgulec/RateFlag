import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class SearchPostCity {
  FirestoreRepository firestoreRepository;
  SearchPostCity(this.firestoreRepository);

  Future<List<Post>> execute(String city) {
    return firestoreRepository.loadPostsByCity(city);
  }
}
