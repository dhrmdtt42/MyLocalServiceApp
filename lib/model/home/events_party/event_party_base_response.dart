import 'package:haarway_app/model/home/events_party/event_party_data_model.dart';

class EventsPartyBaseResponse {
  String status;
  List<EventsPartyData> eventPartyList;

  EventsPartyBaseResponse({this.status, this.eventPartyList});

  factory EventsPartyBaseResponse.fromJson(Map<String, dynamic> eventBaseJson) {
    var list = eventBaseJson['eventsData'] as List;
    print(list.toString());
    List<EventsPartyData> eventPartyList =
        list.map((e) => EventsPartyData.fromJson(e)).toList();
    return EventsPartyBaseResponse(
        status: eventBaseJson['status'], eventPartyList: eventPartyList);
  }
}
