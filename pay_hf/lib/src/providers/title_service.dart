import 'dart:html';
import 'package:angular/angular.dart';

@Injectable()
class TitleService {
  String _title;

  String get title => _title;

  void set title(String value) {
    _title = value;
    if (value != null)
      document.title = '$_title - Pay HF';
    else
      document.title = 'Pay HF';
  }
}
