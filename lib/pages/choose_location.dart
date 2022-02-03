import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(urlstring: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(urlstring: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(urlstring: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(urlstring: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(urlstring: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(urlstring: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(urlstring: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(urlstring: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    //navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isdayTime': instance.isdayTime,
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      
      body: ListView.builder(
          itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
