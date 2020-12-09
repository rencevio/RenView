class Dispatcher {
  const Dispatcher(void Function(dynamic action) dispatch) : _dispatch = dispatch;

  void call(dynamic action) {
    _dispatch(action);
  }

  final void Function(dynamic action) _dispatch;
}
