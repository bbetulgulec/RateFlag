import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/post.dart';

class SearchPostCity {
  FirestoreRepository firestoreRepository;
  SearchPostCity(this.firestoreRepository);

  Future<List<Post>> execute(String city) {
    return firestoreRepository.loadPostsByCity(city);
  }
}
