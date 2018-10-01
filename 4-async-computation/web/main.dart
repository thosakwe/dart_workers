import 'dart:html';
import 'package:json_rpc_2/json_rpc_2.dart' as json_rpc_2;
import 'package:stream_channel/stream_channel.dart';

main() async {
  // Spawn a WebWorker, and Peer.
  var worker = new Worker('worker.dart.js');

  var ctrl = new StreamChannelController<String>();
  ctrl.local.stream.listen(worker.postMessage);
  worker.onMessage.listen((e) => ctrl.local.sink.add(e.data as String));

  var peer = new json_rpc_2.Peer(ctrl.foreign)..listen();

  // Let's compute fibonacci(13) in our worker.
  var response = await peer.sendRequest('fibonacci', {'n': 13}) as Map;
  var result = response['value'] as int;

  window.alert('fib(13) = $result');
}
