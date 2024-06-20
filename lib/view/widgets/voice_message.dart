import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class VoiceMessage extends StatefulWidget {
  final String url;

  VoiceMessage({required this.url});

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
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white),
      
      child: ListTile(
        title: const Text('Voice Message'),
        trailing: IconButton(
          icon: Icon(isButtonPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (isButtonPlaying) {
              _stop();
            } else {
              _play();
            }
          },
        ),
        // onTap: _stop,
      ),
    );
  }
}
