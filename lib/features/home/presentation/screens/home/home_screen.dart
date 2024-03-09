import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_routes.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back button
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey Noah,',
                  style: Theme.of(context).textTheme.headlineMedium),
              AppSizing.vS12(),
              Text(
                'Want some service today?',
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ))
          ],
        ),
        body: Center(child: TextButton(onPressed: () {
          context.goNamed(Routes.homeDetailsNamedPage);
          
        }, child: const Text('Go to Home Details'))));
  }
}
