
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mobile/models/programetv.dart';
import 'package:rxdart/rxdart.dart';

class TVService{
  /// URLS
  static const String _BASE_URL = "http://10.0.2.2:8000/";
  static const String _TV_URL = "telaapi/tv_program";

  bool _certificateCheck(X509Certificate cert, String host, int port) => true;

  TVService();


  /// CREATE A NEW HTTP CLIENT FOR CALLS
  http.Client _newClient() {
    var ioClient = HttpClient()..badCertificateCallback = _certificateCheck;

    return IOClient(ioClient);
  }
  /// GET tv programs
  Future<List<TelaProgrammeTV>> programs() async {
    var client = _newClient();
    List<TelaProgrammeTV> programes =[];
    try{
      print('${Uri.parse(_BASE_URL+_TV_URL)} get programs');
      http.Response response = await client.get(Uri.parse('$_BASE_URL$_TV_URL'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);

        for(var prog in json["images"]){
          programes.add(TelaProgrammeTV.fromJson(prog));
          print(prog);
        }
      }  else {
        print('ERROR reponse status code not 200');
      }

    }
    catch(e){
      print('place api service images error** $e');
    }
    finally{
      client.close();
    }
    return programes;
  }

  List<TelaProgrammeTV> progTest(){
    List<TelaProgrammeTV> list = [];
    list.add(TelaProgrammeTV(id: 1, type: 'Jeux tv', link: 'https://youtu.be/PY_N1XdFp4w?si=KisXUS31Nj44Wavm', webview: true, description: 'jeux', dateTournage: DateTime(2023, 7, 12), dateDiffusion: DateTime(2023, 7, 12)));
    list.add(TelaProgrammeTV(id: 2, type: 'live', link: 'https://m.facebook.com/watch/?v=1031561964648882', facebook: true, webview: true, description: 'Live DIDI B ', dateTournage: DateTime(2022, 10, 20), dateDiffusion: DateTime(2022, 12, 20)));
    list.add(TelaProgrammeTV(id: 3, type: 'Exemple', link: 'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4', description: 'camer ', dateTournage: DateTime(2022, 10, 20), dateDiffusion: DateTime(2022, 12, 20)));
    list.add(TelaProgrammeTV(id: 4, type: 'live', link: 'https://www.facebook.com/video.php?v={837083301751759}', webview: true,  description: '???? ', dateTournage: DateTime(2022, 10, 20), dateDiffusion: DateTime(2022, 12, 20)));
    return list;
  }
  void close(){
  }

}