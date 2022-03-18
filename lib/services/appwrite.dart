import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  static AppwriteService? _instance;
  AppwriteService._internal() {
    Client client = Client();

    client
        .setEndpoint('https://ap.popupbits.com/v1')
        .setProject('FlutterFestivalKTM2022');

    account = Account(client);
    database = Database(client);
  }
  factory AppwriteService() => _instance ??= AppwriteService._internal();

  late final Account account;
  late final Database database;

  Future<DocumentList> fetchQuizes() async {
    DocumentList questions = await database.listDocuments(
      collectionId: 'questions',
    );
    return questions;
  }
}
