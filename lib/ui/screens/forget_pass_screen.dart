import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import '../util/asset_path.dart';
class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController=TextEditingController();
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
                    Text("Your email Address",style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 4,),
                    Text("A 6 digit OTP will sent to your Email address",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey
                        )),
                    SizedBox(height: 4,),
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      //autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value){
                        String email=value??'';
                        if(value?.isEmpty??true)
                        {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),

                    SizedBox(height: 16,),
                    ElevatedButton(onPressed: _onTabSubmitButton, child: Icon(Icons.arrow_circle_right)),
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
    if(_formkey.currentState!.validate()){
      //TODO: Sign in API
      Navigator.pushNamed(context, '/pin-verification');
    }
  }

  void _onTabSignInButton() {
    Navigator.pop(context);
  }
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

}

