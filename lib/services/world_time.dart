import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{

  late String location; //location name for the UI
  late String time; //the time in that location
  late String flag; //url to an asset flag icon
  late String urlstring; //location url for API end point
  late bool isdayTime;
  WorldTime({required this.location,required this.flag,required this.urlstring});

  Future<void> getTime() async {

    try{
      //make the request
      //Response response = await('http://worldtimeapi.org/api/timezone/$url');

      final String apiEndpoint =
          'http://worldtimeapi.org/api/timezone/$urlstring';
      final Uri url = Uri.parse(apiEndpoint);
      final response = await get(url);

      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create a datetime object
      DateTime now =DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isdayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);   //set the time property
    }
    catch (e) {
      time='could not get time data';
    }
  }

}