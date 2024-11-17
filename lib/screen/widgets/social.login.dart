import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.color.dart';
import 'package:flutter_svg/svg.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
             child: Text(
              '-Or sign in with-',
              style: TextStyle(
                color: GlobalColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
        ),
        const SizedBox(height: 15),
        Container(
           width:MediaQuery.of(context).size.width * 0.6 ,
          child: Row(
            children: [
              /// google
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6) ,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      )
                    ]
                  ),
                  child: SvgPicture.asset('assets/images/google.svg', 
                  height: 30,
                  ),
                ),
              ),
              const SizedBox(width: 50),
              /// Facebook
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6) ,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      )
                    ]
                  ),
                  child: SvgPicture.asset('assets/images/facebook.svg', 
                  height: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}