import 'dart:html';
import 'package:json_rpc_2/json_rpc_2.dart' as json_rpc_2;
import 'package:stream_channel/stream_channel.dart';

void main() {
  // Spawn a WebWorker, and bind it to a StreamChannel like earlier.
  var worker = new Worker('worker.dart.js');

  var ctrl = new StreamChannelController<String>();
  ctrl.local.stream.listen(worker.postMessage);
  worker.onMessage.listen((e) => ctrl.local.sink.add(e.data as String));

  // For more complex data, we can use JSON RPC as a means of
  // communication between windows/contexts.
  //
  // Note that a json_rpc_2.Peer can both send and respond to events.
  var peer = new json_rpc_2.Peer(ctrl.foreign);

  // Listen for a notification ("hello") from the worker.
  peer.registerMethod('hello', (json_rpc_2.Parameters params) {
    print('`hello` received: ${params.value}');
  });

  // Start listening for input...
  peer.listen();
}
