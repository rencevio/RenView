import 'package:communicator/communicator.dart';
import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

@FunctionalData()
class AppState extends $AppState {
  const AppState({@required this.communicatorState});

  AppState.initial() : this(communicatorState: CommunicatorState.initial());

  final CommunicatorState communicatorState;
}
