import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

Future<String> getImage(
    String stonkCode, DateTime start, DateTime end, int buy, int sell) async {
  var myUri = Uri.parse(
      'https://stonkgraph-api.an.r.appspot.com/stonk_api/${stonkCode}?start=${start.year}-${start.month}-${start.day}&end=${end.year}-${end.month}-${end.day}&Buy=${buy}&Sell=${sell}');
  final response = await http.get(myUri);
  if (response.statusCode == 200) {
    var document = html_parser.parse(response.body);
    var imgsrc = document.querySelector('img');
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

Future<List<String>> getParagraphs(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var document = html_parser.parse(response.body);
    var pTags = document.getElementsByTagName('p');
    return pTags.map((p) => p.text).toList();
  } else {
    throw Exception('Failed to load the page: ${response.statusCode}');
  }
}
