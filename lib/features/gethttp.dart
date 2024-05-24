import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

Future<String> getImage(String stonkCode, DateTime start, DateTime end) async {
  var myUri = Uri.parse(
      'https://stonkgraph-api.an.r.appspot.com/stonk_api/${stonkCode}?start=${start.year}-${start.month}-${start.day}&end=${end.year}-${end.month}-${end.day}');
  final response = await http.get(myUri);
  if (response.statusCode == 200) {
    var imageUrl = parse(response.body);
    var imgsrc = imageUrl.querySelector('img');
    if (imgsrc != null) {
      var imgUrl = imgsrc.attributes['src'];
      if (imgUrl != null) {
        return imgUrl;
      } else {
        throw Exception(
            'Image tag found, but it does not have a src attribute.');
      }
    }
  } else {
    throw Exception('Failed to load image: ${response.statusCode}');
  }
  throw Exception('Unexpected error occurred.');
}
