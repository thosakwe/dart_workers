import 'package:stream_channel/stream_channel.dart';
import 'interop.dart';

void main() {
  // Just like in `main.dart`, create a StreamChannel<String>
  // by means of a StreamChannelController<String>.
  var ctrl = new StreamChannelController<String>();
  onMessage = (e) => ctrl.local.sink.add(e.data as String);
  ctrl.local.stream.listen(postMessage);

  // Send a message, just like before, but using the
  // StreamChannel abstraction.
  ctrl.foreign.sink.add('Hello from a WebWorker channel!');
}
