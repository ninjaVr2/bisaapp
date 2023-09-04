import 'dart:io';

import 'package:bisa_app/ui/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioScreen extends StatefulWidget {
  AudioScreen({Key? key, required this.fileUrl}) : super(key: key);
  final String fileUrl;

  @override
  _AudioScreenState createState() => _AudioScreenState(fileUrl);
}

void audioPlayerHandler(PlayerState value) => null;

class _AudioScreenState extends State<AudioScreen> {
  bool isPlaying = false;
  String fileUrl;
  _AudioScreenState(this.fileUrl);

  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  String currentPlayingTime = "00:00";
  String completedTime = "00:00";

  void playAudio(String audioFile) async {
    var c = audioFile.split('.');
    if (c[3] != 'mp3' && c[3] != 'mp4' && c[3] != 'caf') {
      c[3] = 'mp3';
      audioFile = c.join('.');
    }
    // audioFile = audioFile.substring(0,audioFile.length-3)+'mp3';
    // audioFile+'mp3';
    print('audio url:$audioFile');
    try {
      if (isPlaying) {
        //If playing then pause audio
        // var res = await audioPlayer.pause();
        // if (res == 1) {
        //   setState(() {
        //     isPlaying = false;
        //   });
        // }
        await audioPlayer.pause();
      } else {
        // var res = await audioPlayer.play(audioFile);
        // if (res == 1) {
        //   setState(() {
        //     isPlaying = true;
        //   });
        // }
        await audioPlayer.play(AssetSource(audioFile));
      }

      // audioPlayer.onSeekComplete.

      audioPlayer.onDurationChanged.listen((Duration dd) {
        setState(() {
          completedTime = dd.toString().split('.')[0];
          duration = dd;
        });
      });

      audioPlayer.onPositionChanged.listen((Duration dd) {
        setState(() {
          currentPlayingTime = dd.toString().split('.')[0];
          position = dd;
        });
      });

      audioPlayer.onPlayerStateChanged.listen((PlayerState dd) {
        setState(() {
          //position =  dd;
        });
      });

      audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          isPlaying = false;
          // duration = Duration(seconds: 0);
          position = Duration(seconds: 0);
        });
      });

      //This is called when an unexpected error is thrown in the native code.

      audioPlayer.onLog.listen((msg) {
        print(msg);
        // _showMyDialog(AppLocalizations.of(context).error);
        setState(() {
          //playerState = PlayerState.stopped;
          isPlaying = false;
          duration = Duration(seconds: 0);
          position = Duration(seconds: 0);
        });

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Popup(
                msg: 'Cannot play audio',
              );
            });
      });
    } catch (t) {
      //mp3 unreachable
      // _showMyDialog(AppLocalizations.of(context).error);
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Popup(
              msg: 'Cannot play audio',
            );
          });
    }
  }

  void quitAudio(context) async {
    // var res = await audioPlayer.stop();
    // if (res == 1) {
    //   setState(() {
    //     isPlaying = false;
    //   });
    // }
    await audioPlayer.stop();
  }

  Widget _slider() {
    var maxD = duration.inSeconds.toDouble() != 0.0
        ? duration.inSeconds.toDouble()
        : 1.0;
    return Slider.adaptive(
        inactiveColor: Colors.grey,
        activeColor: Colors.green,
        min: 0.0,
        value: position.inSeconds.toDouble(),
        // value: 2.0,
        // max: 5.0,
        max: maxD,
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      // to avoid getting "Fatal Error: Callback lookup failed!"
      // audioPlayer.monitorNotificationStateChanges(audioPlayerHandler);
    }
    playAudio(fileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            quitAudio(context);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          playAudio(fileUrl);
                        },
                        child: Icon(
                          isPlaying == false
                              ? Icons.play_circle_outline
                              : Icons.pause_circle_outline,
                          size: 100,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          currentPlayingTime,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '/',
                          style: TextStyle(),
                        ),
                        Text(
                          completedTime,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(child: _slider()),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
