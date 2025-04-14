import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime time;
  final String? imagePath;
  final String? audioPath;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
    this.imagePath,
    this.audioPath,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? Colors.green : Colors.grey.shade700;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (imagePath != null)
              Image.file(
                File(imagePath!),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            if (audioPath != null) _AudioPlayerBubble(audioPath: audioPath!),
            if (text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(text, style: const TextStyle(color: Colors.white)),
              ),
            Text(
              DateFormat.Hm().format(time),
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioPlayerBubble extends StatefulWidget {
  final String audioPath;
  const _AudioPlayerBubble({required this.audioPath});

  @override
  State<_AudioPlayerBubble> createState() => _AudioPlayerBubbleState();
}

class _AudioPlayerBubbleState extends State<_AudioPlayerBubble> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _play() async {
    await _player.setFilePath(widget.audioPath);
    _player.play();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.play_arrow, color: Colors.white),
      onPressed: _play,
    );
  }
}
