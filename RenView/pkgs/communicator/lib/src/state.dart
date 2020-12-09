import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

@FunctionalData()
class CommunicatorState extends $CommunicatorState {
  const CommunicatorState({
    @required this.sessionToken,
  });

  CommunicatorState.initial() : this(sessionToken: const Optional.none());

  final Optional<String> sessionToken;
}
