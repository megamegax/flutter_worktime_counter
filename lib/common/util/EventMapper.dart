import 'package:worktime_flutter/redux/model/models.dart';


String mapEventToString(Event event) {
  switch (event) {
    case Event.BE:
      return 'Érkezés';
    case Event.KI:
      return 'Hazamenés';
    case Event.EBED:
      return 'Ebéd eleje';
    case Event.EBED_VEGE:
      return 'Ebéd vége';
    case Event.SZABI:
      return 'Szabadság';
    default:
      return 'Érkezés';
  }
}

Event mapStringToEvent(String event) {
  switch (event) {
    case 'Érkezés':
      return Event.BE;
    case 'Hazamenés':
      return Event.KI;
    case 'Ebéd eleje':
      return Event.EBED;
    case 'Ebéd vége':
      return Event.EBED_VEGE;
    case 'Szabadság':
      return Event.SZABI;
    default:
      return Event.BE;
  }
}