import 'package:flutter_cars/utils/simple_bloc.dart';
import 'package:provider/provider.dart';

class Event{}

class EventBus extends SimpleBloc<Event> {
  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);

  sendEvent(Event event) {
    add(event);
  }
}
