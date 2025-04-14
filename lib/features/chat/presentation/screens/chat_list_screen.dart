import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/chat_provider.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context).chats;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children:
            chats.entries.map((entry) {
              final name = entry.key;
              final lastMessage =
                  entry.value.isNotEmpty
                      ? entry.value.last.text
                      : "No messages yet";

              return ListTile(
                title: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  lastMessage,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatRoomScreen(username: name),
                    ),
                  );
                },
              );
            }).toList(),
      ),
    );
  }
}
