import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/core/services/network/api_service.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

class MockApiService extends Mock implements ApiService {}
