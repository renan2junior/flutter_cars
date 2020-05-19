import 'dart:async';

class SimpleBloc<T> {
  final _controller = StreamController<T>.broadcast();
  Stream<T> get stream => _controller.stream;

  void add(Object obj) {
    if (!_controller.isClosed) {
      _controller.add(obj);
    }
  }

  void addError(Object obj) {
    if (!_controller.isClosed) {
      _controller.addError(obj);
    }
  }

  void dispose() {
    _controller.close();
  }
}
