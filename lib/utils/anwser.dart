import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:setmain/widgets/driver.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class onBordingScreen extends StatefulWidget {
  const onBordingScreen({super.key});

  @override
  State<onBordingScreen> createState() => _onBordingScreenState();
}

class _onBordingScreenState extends State<onBordingScreen> {

  PageController _controller = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  lastPage = (index == 2);
                });
              },
              children: [
                Container(
                  color: Colors.blueAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 100,),
                      Lottie.network("https://lottie.host/baeadbbc-89df-42ac-9f6e-b2dd64968249/LpENDB3ZQS.json"),
                      SizedBox(height: 20), // Espacement entre l'animation et le texte
                      Text(
                        'Etre serein ...',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 100,),
                      Lottie.network("https://lottie.host/3509fc42-874f-4684-9f79-9dc1516c0e6e/MxHE2EVW64.json"),
                      SizedBox(height: 20), // Espacement entre l'animation et le texte
                      Text(
                        'Etre serein ...',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 100,),
                      Lottie.network("https://lottie.host/d4452f37-0ae6-4c66-b098-617e1ab3b664/HbuDfjdN6E.json"),
                      SizedBox(height: 20), // Espacement entre l'animation et le texte
                      Text(
                        'Etre serein ...',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
                      ),
                    ],
                  ),
                )
              ],
            ),

            Container(
              alignment: Alignment(0,0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Text('Back'),
                    onTap: (){
                      _controller.previousPage(duration: Duration(microseconds: 1000), curve: Curves.easeIn);
                    },
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3),
                  lastPage ?
                  GestureDetector(
                    child: Text('Pret ?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupDriver()));
                    },
                  ):
                  GestureDetector(
                    child: Text('Skip'),
                    onTap: (){},
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
