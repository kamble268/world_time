import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time='';
  String flag;
  String url;
  bool isDay = true;

  WorldTime({required this.location ,required this.flag ,required this.url});

  Future<void> getTime() async {

    try {
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      // print(response.body);
      Map data = jsonDecode(response.body);
      print(data);

      String dataTime = data['datetime'];
      String plus_min = data['utc_offset'].substring(0,1);
      String hrs = data['utc_offset'].substring(1, 3);
      String mins = data['utc_offset'].substring(4, 6);
      // print(dataTime);
      // print(hrs);
      // print(mins);

      DateTime now = DateTime.parse(dataTime);
      now = plus_min == '+' ?
        now.add(Duration(hours: int.parse(hrs), minutes: int.parse(mins))) :
        now.add(Duration(hours: -int.parse(hrs), minutes: -int.parse(mins)))  ;
      // print(now);
      this.isDay = now.hour > 6 && now.hour < 19 ? true : false;
      this.time = DateFormat.jm().format(now);
    }
    catch(e){

      print("error");
      time = 'Failed to load time!';

    }

  }


}
