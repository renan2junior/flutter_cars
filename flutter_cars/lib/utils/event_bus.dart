import 'package:flutter_cars/utils/simple_bloc.dart';
import 'package:provider/provider.dart';

class EventBus extends SimpleBloc<String> {
  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);

  sendEvent(String event) {
    add(event);
  }
}
