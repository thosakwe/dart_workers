@JS()
library worker_interop;

import 'package:js/js.dart';

external void postMessage(String content);

@JS('onmessage')
external void set onMessage(f);

@anonymous
@JS()
class MessageEvent {
  external get data;
}
