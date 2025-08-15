import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import '../util/asset_path.dart';
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _changeController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();

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
                    Text("Set password",style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 4,),
                    // Text("A 6 digit OTP has been sent to your Email",
                    //     style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    //         color: Colors.grey
                    //     )),
                    SizedBox(height: 4,),
                    TextFormField(
                      controller: _changeController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if((value?.length)!<=6)
                        {
                          return "Enter a valid password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 4,),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                      ),
                      validator: (String? value){
                        if((value??'')!=_changeController.text)
                        {
                          return "Password doesn't match!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    ElevatedButton(onPressed: _onTabSubmitButton, child:Text("Confirm")),
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
    }
  }

  void _onTabSignInButton() {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (predicate)=>false);
  }
  void dispose(){
    _changeController.dispose();
    _changeController.dispose();
    super.dispose();
  }

}