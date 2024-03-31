import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/onboardmodel.dart';
import '../shared/cach-helper.dart';
import '../shared/components/components.dart';
import '../shared/constant/colors.dart';
import 'login-screen.dart';

class StartPage extends StatelessWidget {
List <OnBoardModel> onboarditems=[
  OnBoardModel(image: 'assets/images/reg.png',text2: 'Hello there!',text1: 'Welcome to smart greenhouse app'),
  OnBoardModel(image:  'assets/images/farmers-using-modern-farming-technology-4254627-3535116.png',text1:  'Manage your greenhouse',text2: 'Monitor the condition and health of your greenhouse'),
  OnBoardModel(image:  'assets/images/farmer-using-remote-sensors-to-collect-farm-data-4254636-3535125.png',text1:'Manage your greenhouse',text2: 'Make sure your crop is healthy'),
];
// void submit(context){
//   CachHelper.savedata(key: "Onboarding", value: true).then((value)
//   {
//     if(value)
//     {
//       print("last");
//       NavigateToAndReplace(context,LoginScreen());
//     }
//   }
//   );
// }
var pagecontroller=PageController();
  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          // Image.asset('assets/images/76e7eb122af040e6fbe1636f8763d40f.jpg',height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   color: Colors.white.withOpacity(0.99),
          //   colorBlendMode: BlendMode.softLight,
          //   fit: BoxFit.cover,),
          Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (context, index) =>OnBoardItems(onboarditems[index]),
                      itemCount: onboarditems.length,
                      controller: pagecontroller,
                      physics: BouncingScrollPhysics(),

                    ),
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(

                        controller: pagecontroller,

                        count: onboarditems.length,

                        effect: ExpandingDotsEffect(

                            activeDotColor:defaultcolor,

                            radius: 13,

                            dotColor: Colors.grey,

                            spacing: 4,

                            dotHeight: 10,

                            dotWidth: 14,

                            expansionFactor: 3



                        ),

                        axisDirection: Axis.horizontal,





                      ),
                      Spacer(),
                      MaterialButton(onPressed: (){
                        // submit(context);
                        CachHelper.savedata(key: "Onboarding", value: true).then((value)
                        {
                          NavigateToAndReplace(context,LoginScreen());
                        }
                        );

                      },

                          child:  Text("Get Started",style: TextStyle(color: defaultcolor,fontSize: 18),)
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      );
  }
}
