import 'interop.dart';

// We're still technically not printing, but we WILL be sending
// a message back to the caller!
void main() => postMessage('Hello from a WebWorker!');
