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
  peer.listen();

  // Send the expected "hello" notification to the main window.
  // 
  // Note that we're now sending a list, since only lists and maps may be
  // sent directly via JSON RPC.
  peer.sendNotification('hello', ['Hello from a WebWorker JSON RPC peer!']);
}
