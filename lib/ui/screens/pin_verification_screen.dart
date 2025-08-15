import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import '../util/asset_path.dart';
class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text("PIN Verification",style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 4,),
                    Text("A 6 digit OTP has been sent to your Email",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey
                        )),
                    SizedBox(height: 4,),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      controller: _otpController,
                      appContext: context, 
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box, 
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 45,
                        inactiveColor: Colors.grey,
                        activeColor: Colors.green,
                        selectedColor: Colors.green,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        borderWidth: 1,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true, 
                      backgroundColor: Colors.transparent,
                      onChanged: (value) {},
                    ),

                    SizedBox(height: 8,),
                    SizedBox(height: 16,),
                    ElevatedButton(onPressed: _onTabSubmitButton, child:Text("Verify")),
                    SizedBox(height: 32,),

                    Center(
                      child: RichText(text: TextSpan(
                        text: "Have account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5
                        ),
                        children: [
                          TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()..onTap=_onTabSignInButton
                          ),
                        ],
                      ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  

  void _onTabSubmitButton(){
    if (_otpController.text.length == 6) {
      Navigator.pushNamed(context, '/change-password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all 6 digits')),
      );
    }
  }
  void _onTabSignInButton() {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (predicate)=>false);
  }
  void dispose(){
    _otpController.dispose();
    super.dispose();
  }

}
