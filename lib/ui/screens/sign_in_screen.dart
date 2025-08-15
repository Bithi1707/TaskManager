import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import '../../data/models/user_models.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../controller/auth_controller.dart';
import '../util/asset_path.dart';
import '../widgets/center_circular_indicator.dart';
import '../widgets/snack_bar_message.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


final TextEditingController _emailController=TextEditingController();
final TextEditingController _passController=TextEditingController();
 final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
bool _signInProgress = false;


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
              Text("Get Started With",style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 24,),
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
              TextFormField(
                obscureText: true,
                controller: _passController,
                //autovalidateMode: AutovalidateMode.always,
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
              SizedBox(height: 16,),
              Visibility(
                visible: _signInProgress ==false,
                  replacement: CenterCircularIndicator(),
                  child:
                  ElevatedButton(onPressed: _onTabSignInButton, child: Icon(Icons.arrow_circle_right))),
              SizedBox(height: 32,),
              Center(
                child: Column(
                  children: [
                    TextButton(onPressed: _onTabForgetPasswordButton, child: Text('Forget password?',style: TextStyle(
                      color: Colors.grey
                    ),)),
                  ],
                ),
              ),

            Center(
              child: Column(
                children: [
                  RichText(text: TextSpan(
                    text: "Don't have any account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 0.5
                    ),
                    children: [
                      TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap=_onTabSignUpButton
                      ),
                    ],
                  ),
                  ),
                ],
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
  void _onTabSignInButton(){
   if(_formkey.currentState!.validate()){
     _signIn();
   }
  }

Future<void> _signIn() async {
  setState(() => _signInProgress = true);

  Map<String, String> requestBody = {
    "email": _emailController.text.trim(),
    "password": _passController.text,
  };

  final response = await NetworkCaller.postRequest(
    url: Urls.loginUrl,
    body: requestBody,
  );

  setState(() => _signInProgress = false);

  if (response.isSuccess) {
    UserModel userModel = UserModel.fromJson(response.body!['data']);
    String token = response.body!['token'];

    await AuthController.saveUserData(userModel, token);
    Navigator.pushNamedAndRemoveUntil(context, '/main_nav_bar_holder', (predicate)=>false);
  } else {
    _signInProgress=false;
    showSnackBarMessage(context, response.errorMessage!);
  }
}


void _onTabForgetPasswordButton(){
  Navigator.pushNamed(context, '/forget-pass');
  }
  void _onTabSignUpButton() {
    Navigator.pushNamed(context, '/sign-up');
  }
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

}


