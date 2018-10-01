import 'dart:html';

void main() {
  // Spawn a WebWorker.
  //
  // Note that we pass the outputted JS file name,
  // rather than just "worker.dart".
  new Worker('worker.dart.js');
}