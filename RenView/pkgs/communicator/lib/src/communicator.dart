import 'package:meta/meta.dart';
import '../communicator.dart';

class Communicator {
  Future<void> login({
    @required void Function(String token) onSuccess,
    @required void Function(LoginFailureReason) onError,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2)).then((_) => onError(LoginFailureReason.unknown));
  }
}
