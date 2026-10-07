import '../data/store_repository.dart';

String errorMessage(Object error) {
  return error is StoreDataException
      ? error.message
      : 'Something went wrong. Please try again.';
}
