import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Aud extends StatefulWidget {
  const Aud({Key? key}) : super(key: key);

  @override
  State<Aud> createState() => _AudState();
}

class _AudState extends State<Aud> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  // void dispose() {
  //  assetsAudioPlayer.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    assetsAudioPlayer.open(
      Audio("assets/audio/notification_sound.mp3"),
      loopMode: LoopMode.single,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("You Have a New Message",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                SizedBox(width: 58,),
                IconButton(onPressed: () {
                  assetsAudioPlayer.stop();
                  Navigator.pop(context);
                }, icon: Icon(Icons.close)),
              ],
            ),
            // SizedBox(width: 5,),

            SizedBox(height: 90,),
            Lottie.asset("assets/icons/notifi.json")

          ],
        ),
      )

    );
  }
}
