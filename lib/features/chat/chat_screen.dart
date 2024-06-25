import 'package:flutter/material.dart';
import 'package:chattapp/features/chat/chat_repository.dart';
import 'package:chattapp/features/chat/chat_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.chatRepository,
  });

  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<ChatMessage>(
              stream: chatRepository.messages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text("Fehler beim Laden der Nachrichten"));
                } else if (!snapshot.hasData) {
                  return const Center(
                      child: Text("Keine Nachrichten verfügbar"));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount:
                        1, // Da immer nur eine neue Nachricht gestreamt wird
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages.user),
                        subtitle: Text(messages.message),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                chatRepository.startSendingMessages();
              },
              child: const Text("Start Sending Messages"),
            ),
          ),
        ],
      ),
    );
  }
}
