import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/longIconButton.dart';
import 'package:quikhyr/features/auth/presentation/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/models/user_model.dart';

import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  PageController pageController = PageController();
  int _curr=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: _list,
         onPageChanged: (num) {
    setState(() {
      _curr = num;
    });
  },
      ),
    );
  }

}
  // final passwordController = TextEditingController();
  // final emailController = TextEditingController();
  // final nameController = TextEditingController();
  
  // final _formKey = GlobalKey<FormState>();
  // IconData iconPassword = CupertinoIcons.eye_fill;
  // bool obscurePassword = true;
  // bool signUpRequired = false;

  // bool containsUpperCase = false;
  // bool containsLowerCase = false;
  // bool containsNumber = false;
  // bool containsSpecialChar = false;
  // bool contains8Length = false;

  
  //   return Scaffold(
      
  //     body: BlocListener<SignUpBloc, SignUpState>(
  //       listener: (context, state) {
  //         if (state is SignUpSuccess) {
  //           setState(() {
  //             signUpRequired = false;
  //           });
  //           // Navigator.pop(context);
  //         } else if (state is SignUpProcess) {
  //           setState(() {
  //             signUpRequired = true;
  //           });
  //         } else if (state is SignUpFailure) {
  //           return;
  //         }
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.all(24.0),
  //         child: Center(
  //           child: Form(
  //             key: _formKey,
  //             child: Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Center(
  //                                   child: SvgPicture.asset(
  //                                     AppAssetLinks.logoSvg,
  //                                     width: 200,
  //                                   ),
  //                                 ),
  //                         const SizedBox(height: 32),
  //                         const Align(
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Text(
  //                                     "Name",
  //                                     style: TextStyle(
  //                                       color: Color(
  //                                           0xFFE9EAEC), // Replace with the equivalent Flutter color
  //                                       fontFamily:
  //                                           'Trap', // Ensure 'Trap' font is added to your pubspec.yaml
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.w800,
  //                                       height: 1,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(height: 12),
  //                         SizedBox(
  //                           width: MediaQuery.of(context).size.width * 0.9,
  //                           child: MyTextField(
  //                               controller: emailController,
  //                               hintText: 'Enter name*',
  //                               obscureText: false,
  //                               keyboardType: TextInputType.emailAddress,
                                
  //                               validator: (val) {
  //                                 if (val!.isEmpty) {
  //                                   return 'Please fill in this field';
  //                                 } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
  //                                     .hasMatch(val)) {
  //                                   return 'Please enter a valid email';
  //                                 }
  //                                 return null;
  //                               }),
  //                         ),
  //                         const SizedBox(height: 24),
  //                         const Align(
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Text(
  //                                     "Phone and Email",
  //                                     style: TextStyle(
  //                                       color: Color(
  //                                           0xFFE9EAEC), // Replace with the equivalent Flutter color
  //                                       fontFamily:
  //                                           'Trap', // Ensure 'Trap' font is added to your pubspec.yaml
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.w800,
  //                                       height: 1,
  //                                     ),
  //                                   ),),
  //                                   SizedBox(height: 12.0,),
  //                         SizedBox(
  //                           width: MediaQuery.of(context).size.width * 0.9,
  //                           child: MyTextField(
  //                               controller: passwordController,
  //                               hintText: 'Enter phone*',
  //                               obscureText: obscurePassword,
  //                               keyboardType: TextInputType.visiblePassword,
                               
  //                               onChanged: (val) {
  //                                 if (val!.contains(RegExp(r'[A-Z]'))) {
  //                                   setState(() {
  //                                     containsUpperCase = true;
  //                                   });
  //                                 } else {
  //                                   setState(() {
  //                                     containsUpperCase = false;
  //                                   });
  //                                 }
  //                                 if (val.contains(RegExp(r'[a-z]'))) {
  //                                   setState(() {
  //                                     containsLowerCase = true;
  //                                   });
  //                                 } else {
  //                                   setState(() {
  //                                     containsLowerCase = false;
  //                                   });
  //                                 }
  //                                 if (val.contains(RegExp(r'[0-9]'))) {
  //                                   setState(() {
  //                                     containsNumber = true;
  //                                   });
  //                                 } else {
  //                                   setState(() {
  //                                     containsNumber = false;
  //                                   });
  //                                 }
  //                                 if (val.contains(RegExp(
  //                                     r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
  //                                   setState(() {
  //                                     containsSpecialChar = true;
  //                                   });
  //                                 } else {
  //                                   setState(() {
  //                                     containsSpecialChar = false;
  //                                   });
  //                                 }
  //                                 if (val.length >= 8) {
  //                                   setState(() {
  //                                     contains8Length = true;
  //                                   });
  //                                 } else {
  //                                   setState(() {
  //                                     contains8Length = false;
  //                                   });
  //                                 }
  //                                 return null;
  //                               },
  //                               suffixIcon: IconButton(
  //                                 onPressed: () {
  //                                   setState(() {
  //                                     obscurePassword = !obscurePassword;
  //                                     if (obscurePassword) {
  //                                       iconPassword = CupertinoIcons.eye_fill;
  //                                     } else {
  //                                       iconPassword = CupertinoIcons.eye_slash_fill;
  //                                     }
  //                                   });
  //                                 },
  //                                 icon: Icon(iconPassword),
  //                               ),
  //                               validator: (val) {
  //                                 if (val!.isEmpty) {
  //                                   return 'Please fill in this field';
  //                                 } else if (!RegExp(
  //                                         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
  //                                     .hasMatch(val)) {
  //                                   return 'Please enter a valid password';
  //                                 }
  //                                 return null;
  //                               }),
  //                         ),
  //                         const SizedBox(height: 12),
                                               
                          
                          
  //                         SizedBox(
  //                           width: MediaQuery.of(context).size.width * 0.9,
  //                           child: MyTextField(
  //                               controller: nameController,
  //                               hintText: 'Enter email*',
  //                               obscureText: false,
  //                               keyboardType: TextInputType.name,
  //                               validator: (val) {
  //                                 if (val!.isEmpty) {
  //                                   return 'Please fill in this field';
  //                                 } else if (val.length > 30) {
  //                                   return 'Name too long';
  //                                 }
  //                                 return null;
  //                               }),
  //                         ),
  //                         SizedBox(height: 5,),
  //                         const Align(
  //                                   alignment: Alignment.centerRight,
  //                                   child: Text(
  //                                     "*Required",
  //                                     style: TextStyle(
  //                                       color: Color.fromRGBO(233, 234, 236, 0.50),
  //                                       fontFamily: 'Trap',
  //                                       fontSize: 12,
  //                                       fontStyle: FontStyle.normal,
  //                                       fontWeight: FontWeight.w600,
                                        
  //                                     ),
  //                                   ),
  //                                 ),
  //                       ],
  //                     ),
  //                   ),
  //                   Column(
  //                     children: [
  //                       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
  //                   !signUpRequired
  //                       ? SizedBox(
  //                           width: MediaQuery.of(context).size.width * 0.5,
  //                           child: TextButton(
  //                               onPressed: () {
  //                                 if (_formKey.currentState!.validate()) {
  //                                   UserModel userModel = UserModel.empty;
  //                                   userModel = userModel.copyWith(
  //                                     email: emailController.text,
  //                                     name: nameController.text,
  //                                   );
  //                                   setState(() {
  //                                     context.read<SignUpBloc>().add(SignUpRequired(
  //                                         userModel, passwordController.text));
  //                                   });
  //                                 }
  //                               },
  //                               style: TextButton.styleFrom(
  //                                   elevation: 3.0,
  //                                   backgroundColor:
  //                                       Theme.of(context).colorScheme.primary,
  //                                   foregroundColor: Colors.white,
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(60))),
  //                               child: const Padding(
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: 25, vertical: 5),
  //                                 child: Text(
  //                                   'Set Password',
  //                                   textAlign: TextAlign.center,
  //                                   style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.w600),
  //                                 ),
  //                               )),
  //                         )
  //                       : const CircularProgressIndicator(),
  //                       SizedBox(height: 20,),
  //                       RichText(
  //                           text: TextSpan(
  //                             text: "Already have an account?",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyMedium
  //                                 ,
  //                             children: [
  //                               TextSpan(
  //                                 text: " Log in ",
  //                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
class Pages extends StatelessWidget {
  
  final Color color;
  final String buttonText;
  final List<Widget> children;

  Pages({
    
    required this.color,
    required this.buttonText,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetLinks.welcomeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssetLinks.logoSvg,
                      width: 200,
                    ),
                    ...children,
                    SizedBox(height: 5.0,),
                    const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "*Required",
                                style: TextStyle(
                                  color: Color.fromRGBO(233, 234, 236, 0.50),
                                  fontFamily: 'Trap',
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  
                                ),
                              ),
                            ),
                  ],
                ),
              ),
              Column(
                children: [
                  LongIconButton(text: buttonText, onPressed: (){}),
                  SizedBox(height: 20.0,),
                  const Text("Already have an account? Log in"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Widget> _list = <Widget>[
  Pages(
    
    color: Colors.teal,
    buttonText: "Set Password",
    children: [
      const SizedBox(height: 32.0,),
      Align(
        alignment: Alignment.centerLeft,
        child: const Text("Name", style: TextStyle(
                                    color: Color(
                                        0xFFE9EAEC),
                                    fontFamily:
                                        'Trap', 
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),),
      ),
                                const SizedBox(height: 12.0,),
      MyTextField(
        controller: TextEditingController(),
        hintText: "Enter name*", obscureText: false, keyboardType: TextInputType.text ,),
        const SizedBox(height: 24.0,),
      Align(
        alignment: Alignment.centerLeft,
        child: const Text("Phone and Email",style: TextStyle(
                                    color: Color(
                                        0xFFE9EAEC),
                                    fontFamily:
                                        'Trap', 
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),),
      ),
                                const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Enter phone*", obscureText: false, keyboardType: TextInputType.text ,),
        const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Enter email*", obscureText: false, keyboardType: TextInputType.text ,),
    ],
  ),
  Pages(
    
    color: Colors.red.shade100,
    buttonText: "Profile Info",
    children: [
      const SizedBox(height: 64.0,),
      Align(
        alignment: Alignment.centerLeft,
        child: const Text("Set Password",style: TextStyle(
                                    color: Color(
                                        0xFFE9EAEC),
                                    fontFamily:
                                        'Trap', 
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),),
      ),
                                const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Enter password*", obscureText: false, keyboardType: TextInputType.text ,),
        const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Re-enter password*", obscureText: false, keyboardType: TextInputType.text ,),
    ],
  ),
  Pages(
   
    color: Colors.grey,
    buttonText: "Continue",
    children: [
      const SizedBox(height: 64.0,),
      Align(
        alignment: Alignment.centerLeft,
        child: const Text("Profile Information",style: TextStyle(
                                    color: Color(
                                        0xFFE9EAEC),
                                    fontFamily:
                                        'Trap', 
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),),
      ),
                                const SizedBox(height: 12.0,),
      // MyTextField(controller: TextEditingController(),
      //   hintText: "Select Role*", obscureText: false, keyboardType: TextInputType.text ,),
      //   const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Select Gender", obscureText: false, keyboardType: TextInputType.text ,),
        const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Enter date of birth*", obscureText: false, keyboardType: TextInputType.text ,),
        const SizedBox(height: 12.0,),
      MyTextField(controller: TextEditingController(),
        hintText: "Enter address*", obscureText: false, keyboardType: TextInputType.text ,),
    ],
  ),
];