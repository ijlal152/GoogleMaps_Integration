import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlaceApiScreen extends StatefulWidget {
  const GooglePlaceApiScreen({Key? key}) : super(key: key);

  @override
  State<GooglePlaceApiScreen> createState() => _GooglePlaceApiScreenState();
}

class _GooglePlaceApiScreenState extends State<GooglePlaceApiScreen> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState(){
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken == null){
      setState((){
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async{
    String Places_Api_Key = "AIzaSyD3xXlbGsMd3u-lTK31OBm8xG6MHL6Rb8E";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$Places_Api_Key&sessiontoken=$_sessionToken';
    
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');
    print(data);
    //print(response.body.toString());
    if(response.statusCode == 200){
      setState((){
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Search Places Api'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search places with name',
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _placesList.length,
                    itemBuilder: (context, index){
                    return ListTile(
                      title: Text(_placesList[index]['description']),
                    );
                })
            ),
          ],
        ),
      ),
    );
  }
}
