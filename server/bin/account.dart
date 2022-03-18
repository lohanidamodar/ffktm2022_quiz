import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

class AppwriteService {
  static AppwriteService? _instance;
  AppwriteService._internal() {
    Client client = Client();

    client
        .setEndpoint('https://ap.popupbits.com/v1')
        .setProject('FlutterFestivalKTM2022')
        .setKey(
          '2e19fcb82564403a6862bc64a274588ece976a8e97d042161026473d7d4663354afdad73f104263cddf938b8f89dcb62a0a24681bfb113e4e651103f46d04118b0523b1a96a0ccd0fa4c08c060488fb91e6839c73a6dbfeab979f3a62c9a1b98691c42c572b8c57a5534191a7870f9893bbdc077f0fda572b957b5516f36c9d4',
        );

    account = Account(client);
    database = Database(client);
  }
  factory AppwriteService() => _instance ??= AppwriteService._internal();

  late final Account account;
  late final Database database;

  Future<DocumentList> fetchQuizes() async {
    DocumentList questions = await database.listDocuments(
      collectionId: 'questions',
      limit: 10,
    );
    return questions;
  }
}
