import 'dart:async';

import 'package:chattapp/features/chat/chat_message.dart';

const messageInterval = Duration(seconds: 4);

class ChatRepository {
  final StreamController<ChatMessage> _controller =
      StreamController<ChatMessage>();
  Timer? _timer;

  Stream<ChatMessage> get messages => _controller.stream;

  void startSendingMessages() {
    int messageIndex = 0;

    _timer = Timer.periodic(messageInterval, (timer) {
      if (messageIndex < mockMessages.length) {
        receiveMessage(mockMessages[messageIndex++]);
      } else {
        // Optional: Stoppen des Timers, wenn alle Nachrichten gesendet wurden
        timer.cancel();
      }
    });
  }

  void stopSendingMessages() {
    _timer?.cancel();
  }

  void receiveMessage(ChatMessage message) {
    _controller.sink.add(message);
  }

  void dispose() {
    stopSendingMessages();
    _controller.close();
  }
}
