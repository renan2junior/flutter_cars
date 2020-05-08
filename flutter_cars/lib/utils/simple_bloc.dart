import 'dart:async';

class SimpleBloc<T> {
  final _controller = StreamController<T>();
  get stream => _controller.stream;

  void add(Object obj) {
    _controller.add(obj);
  }

  void addError(Object obj) {
    _controller.addError(obj);
  }

  void dispose() {
    _controller.close();
  }
}
