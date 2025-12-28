import 'package:rate_flag/features/rate_flag/domain/model/user.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class SearchUserByUsername {
  final FirestoreRepository repository;

  SearchUserByUsername(this.repository);

  Future<List<User>> execute(String input) async {
    final normalizedUsername = input.toLowerCase().replaceAll("@", "").trim();

    if (normalizedUsername.isEmpty) return [];

    final users = await repository.searchUserByFirstName(normalizedUsername);
    return users;
  }
}
