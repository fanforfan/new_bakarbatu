import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bakarbatu/features/contribution/presentation/bloc/submit_article/submit_article_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecording extends StatefulWidget {
  const AudioRecording({Key? key}) : super(key: key);

  @override
  _AudioRecordingState createState() => _AudioRecordingState();
}

class _AudioRecordingState extends State<AudioRecording> {
  String statusText = 'Click to record audio.';
  FlutterAudioRecorder2? _recorder;
  Recording? _current;
  var _currentStatus = RecordingStatus.Unset;
  AudioPlayer audioPlayer = AudioPlayer();
  var canPlay = true;

  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _createTextDuration(),
        const SizedBox(
          height: 10.0,
        ),
        _currentStatus != RecordingStatus.Stopped
            ? _createAudioRecorder()
            : _createControllerPlayAudio(),
      ],
    );
  }

  Widget _createTextDuration() {
    return Center(
      child: Text('${_current?.duration.toString()}', style: const TextStyle(color: Colors.grey),),
    );
  }

  Widget _createAudioRecorder() {
    return _currentStatus == RecordingStatus.Initialized
        ? MaterialButton(
      onPressed: () {
        _start();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              'assets/icons/ic_pick_audio.png',
              width: 50,
            ),
            const Text(
              'Click to rec audio',
              style: TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            ),
          ],
        ),
      ),
    )
        : _currentStatus == RecordingStatus.Recording
        ? MaterialButton(
      onPressed: () {
        _stop();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              'assets/icons/ic_stop_record.png',
              width: 50,
            ),
            const Text(
              'Stop',
              style: TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            ),
          ],
        ),
      ),
    )
        : const SizedBox();
  }

  Widget _createControllerPlayAudio(){
    return MaterialButton(
      onPressed: () {
        onPlayAudio();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 0.5, color: const Color.fromARGB(255, 154, 0, 0)),
            color: const Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              canPlay ? 'assets/icons/ic_play_audio.png' : 'assets/icons/ic_stop_record.png',
              width: 50,
            ),
            Text(
              statusText,
              style: const TextStyle(
                  color: Color.fromARGB(255, 154, 0, 0), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  initAudio() async {
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/bakarbatu_audio_recorder_';
        Directory appDocDirectory = await getApplicationDocumentsDirectory();

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = '${appDocDirectory.path}$customPath${DateTime.now().millisecondsSinceEpoch}';

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder = FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder!.initialized;
        var current = await _recorder!.current(channel: 0);
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You must accept permissions")));
      }
    } catch (e) {
      debugPrint('ERROR GAES $e');
    }
  }

  _start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);

        setState(() {
          _current = current;
          _currentStatus = _current!.status!;
        });
      });
    } catch (e) {
      debugPrint('ERROR GAES : $e');
    }
  }

  _resume() async {
    await _recorder!.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder!.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder!.stop();
    BlocProvider.of<SubmitArticleBloc>(context)
        .add(PickAudio(audioFile: File('${result?.path}')));
    debugPrint("Stop recording: ${result?.path}");
    debugPrint("Stop recording: ${result?.duration}");
    setState(() {
      statusText = 'Play Audio';
      _current = result;
      _currentStatus = _current!.status!;
    });
  }

  onPlayAudio() async {
    if(canPlay){
      setState(() {
        canPlay = false;
        statusText = 'Stop Playing';
      });
      await audioPlayer.play(DeviceFileSource(_current!.path!));
    }else{
      setState(() {
        canPlay = true;
        statusText = 'Play Audio';
      });
      await audioPlayer.stop();
    }
  }
}
