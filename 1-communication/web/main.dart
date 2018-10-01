import 'dart:html';

void main() {
  // Spawn a WebWorker.
  var worker = new Worker('worker.dart.js');

  // A worker can post data back to the caller.
  //
  // We can listen for an event that fires whenever such a message is sent.
  worker.onMessage.listen((e) {
    print('From worker: ${e.data}');
  });
}