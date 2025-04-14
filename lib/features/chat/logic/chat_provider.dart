import 'package:flutter/material.dart';
import 'dart:async';

class Message {
  final String text;
  final String sender;
  final DateTime time;
  final String? imagePath;
  final String? audioPath; // ✅ جديد

  Message(this.text, this.sender, this.time, {this.imagePath, this.audioPath});
}

class ChatProvider with ChangeNotifier {
  final Map<String, List<Message>> chats = {
    "Alex": [
      Message(
        "Hi there!",
        "Alex",
        DateTime.now().subtract(const Duration(minutes: 40)),
      ),
      Message(
        "Hello!",
        "Me",
        DateTime.now().subtract(const Duration(minutes: 39)),
      ),
    ],
  };

  ChatProvider() {
    Timer.periodic(const Duration(minutes: 1), (_) => _cleanupOldMessages());
  }

  void sendMessage(String to, String text) {
    chats[to] ??= [];
    chats[to]!.add(Message(text, "Me", DateTime.now()));
    notifyListeners();
  }

  void sendImageMessage(String to, String imagePath) {
    chats[to] ??= [];
    chats[to]!.add(Message("", "Me", DateTime.now(), imagePath: imagePath));
    notifyListeners();
  }

  void sendAudioMessage(String to, String audioPath) {
    chats[to] ??= [];
    chats[to]!.add(Message("", "Me", DateTime.now(), audioPath: audioPath));
    notifyListeners();
  }

  List<Message> getMessages(String user) => chats[user] ?? [];

  void _cleanupOldMessages() {
    final now = DateTime.now();

    chats.forEach((contact, messages) {
      if (messages.isEmpty) return;

      final lastSender = messages.last.sender;

      // إذا آخر رسالة مني "Me"، وكانت أقدم من 30 دقيقة، وما فيه رد
      if (lastSender == "Me") {
        final lastTime = messages.last.time;
        if (now.difference(lastTime).inMinutes >= 30) {
          messages.clear(); // نحذف كل المحادثة
          debugPrint("Deleted messages with $contact due to no response.");
        }
      }
    });

    notifyListeners();
  }
}
