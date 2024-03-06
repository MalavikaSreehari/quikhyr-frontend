import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr/common/LongIconButton.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:quikhyr/features/auth/presentation/screens/sign_up_screen.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => BlocProvider(
              //         create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
              //         child: const SignInScreen(),
              //       ),
              //     ),
              //   );
              // },
              //   child: const Text('Sign In'),
              LongIconButton(
                text: "Let's get started",
                svgPath: AppAssetLinks.rightArrowSvg,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SignInBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository),
                        child: const SignInScreen(),
                      ),
                    ),
                  );
                },
              ),
              LongIconButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                text: "Already have an account",
                svgPath: AppAssetLinks.rightArrowSvg,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SignUpBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository),
                        child: const SignUpScreen(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
