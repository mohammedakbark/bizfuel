import 'package:bizfuel/utils/string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class VoiceMessage extends StatefulWidget {
  final String url;
  final String anotheruid;

  VoiceMessage({required this.url, required this.anotheruid});

  @override
  _VoiceMessageState createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage> {
  FlutterSoundPlayer? _player;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _player!.openPlayer();
  }

  @override
  void dispose() {
    _player!.closePlayer();
    _player = null;
    super.dispose();
  }

  bool isButtonPlaying = false;
  Future<void> _play() async {
    isButtonPlaying = true;
    setState(() {});
    await _player!.startPlayer(
      fromURI: widget.url,
      whenFinished: () {
        isButtonPlaying = false;
        setState(() {});
      },
    );
  }

  Future<void> _stop() async {
    isButtonPlaying = false;
    setState(() {});
    await _player!.stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    bool isMe = widget.anotheruid == FirebaseAuth.instance.currentUser!.uid;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: Helper.W(context) / 2,
      // ignore: prefer_const_constructors
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(0))
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Voice Message'),
          IconButton(
            icon: Icon(isButtonPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (isButtonPlaying) {
                _stop();
              } else {
                _play();
              }
            },
          ),
        ],
      ),
    );
  }
}
