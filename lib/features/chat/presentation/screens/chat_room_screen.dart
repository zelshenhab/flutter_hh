import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../logic/chat_provider.dart';
import '../widgets/chat_bubble.dart';

class ChatRoomScreen extends StatefulWidget {
  final String username;
  const ChatRoomScreen({super.key, required this.username});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final AudioRecorder _recorder = AudioRecorder();
  bool isRecording = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _sendTextMessage(ChatProvider provider) async {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      provider.sendMessage(widget.username, text);
      _textController.clear();
    }
  }

  Future<void> _pickAndSendImage(ChatProvider provider) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      provider.sendImageMessage(widget.username, image.path);
    }
  }

  Future<void> _handleAudio(ChatProvider provider) async {
    if (isRecording) {
      final path = await _recorder.stop();
      if (path != null) {
        provider.sendAudioMessage(widget.username, path);
      }
    } else {
      if (await _recorder.hasPermission()) {
        final dir = await getTemporaryDirectory();
        final filePath =
            '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _recorder.start(const RecordConfig(), path: filePath);
      }
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final messages = chatProvider.getMessages(widget.username);

    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children:
                  messages.reversed.map((msg) {
                    return ChatBubble(
                      text: msg.text,
                      isMe: msg.sender == "Me",
                      time: msg.time,
                      imagePath: msg.imagePath,
                      audioPath: msg.audioPath,
                    );
                  }).toList(),
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () => _pickAndSendImage(chatProvider),
                  ),
                  IconButton(
                    icon: Icon(isRecording ? Icons.stop : Icons.mic),
                    onPressed: () => _handleAudio(chatProvider),
                    color: isRecording ? Colors.red : null,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _sendTextMessage(chatProvider),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
