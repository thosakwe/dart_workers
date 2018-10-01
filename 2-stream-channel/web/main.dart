import 'dart:html';
import 'package:stream_channel/stream_channel.dart';

void main() {
  // Spawn a WebWorker.
  var worker = new Worker('worker.dart.js');

  // Let's use a StreamChannelController that abstracts over
  // communication via postMessage.
  var ctrl = new StreamChannelController<String>();

  // We put data through `ctrl.local`. Output from the worker is
  // sent through `ctrl.foreign`.
  ctrl.local.stream.listen(worker.postMessage);
  worker.onMessage.listen((e) => ctrl.local.sink.add(e.data as String));

  // Listen for a message from the worker.
  ctrl.foreign.stream.listen((msg) {
    print('From worker channel: $msg');
  });
}
