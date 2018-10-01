import 'package:js/js.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as json_rpc_2;
import 'package:stream_channel/stream_channel.dart';
import 'interop.dart';

void main() {
  // Just like in `main.dart`, create a json_rpc_2.Peer.
  var ctrl = new StreamChannelController<String>();
  onMessage = allowInterop((e) => ctrl.local.sink.add(e.data as String));
  ctrl.local.stream.listen(postMessage);

  var peer = new json_rpc_2.Peer(ctrl.foreign);

  // When the main window requests a fibonacci computation,
  // we can handle it within the worker.
  peer.registerMethod('fibonacci', (json_rpc_2.Parameters params) {
    // Read the input value(s) in a type-safe fashion.
    var n = params['n'].asInt;
    var value = fibonacci(n);

    // We can return a Map with the result, and that will be
    // sent to the client that requested it (the main window, in this case).
    return {'value': value};
  });

  peer.listen();
}

int fibonacci(int n) => n <= 2 ? 1 : fibonacci(n - 2) + fibonacci(n - 1);
