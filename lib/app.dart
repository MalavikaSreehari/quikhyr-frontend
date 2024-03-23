import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr/app_view.dart';
import 'package:quikhyr/common/bloc/client_bloc.dart';
import 'package:quikhyr/common/data/repositories/client_repo.dart';
import 'package:quikhyr/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr/features/home/blocs/bloc/most_rated_workers_bloc.dart';
import 'package:quikhyr/features/home/blocs/bloc/search_bloc.dart';
import 'package:quikhyr/features/home/blocs/bloc/services_category_bloc.dart';
import 'package:quikhyr/features/home/data/repository/most_rated_workers_repo.dart';
import 'package:quikhyr/features/home/data/repository/search_repo.dart';
import 'package:quikhyr/features/home/data/repository/services_category_repo.dart';

class MyApp extends StatelessWidget {
  final FirebaseUserRepo userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ClientRepo>(
          create: (context) => ClientRepo(),
        ),
        RepositoryProvider<MostRatedWorkersRepo>(
            create: (context) => MostRatedWorkersRepo()),
        RepositoryProvider<ServicesCategoryRepo>(
          create: (context) => ServicesCategoryRepo(),
        ),
        RepositoryProvider<SearchRepo>(create: (context) => SearchRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository),
          ),
          BlocProvider(
            create: (context) => SignInBloc(userRepository: userRepository),
          ),
          BlocProvider<ServicesCategoryBloc>(create: (context) {
            final servicesCategoryRepo =
                RepositoryProvider.of<ServicesCategoryRepo>(context);
            return ServicesCategoryBloc(
                servicesCategoryRepo: servicesCategoryRepo)
              ..add(LoadServicesCategories());
          }),
          BlocProvider<MostRatedWorkersBloc>(create: (context) {
            final repo = RepositoryProvider.of<MostRatedWorkersRepo>(context);
            return MostRatedWorkersBloc(repo: repo)
              ..add(FetchMostRatedWorkers());
          }),
          BlocProvider<SearchBloc>(
            create: (context) {
              final searchRepo = RepositoryProvider.of<SearchRepo>(context);
              return SearchBloc(searchRepo: searchRepo);
            },
          ),
          BlocProvider<ClientBloc>(
            create: (context) {
              final clientRepo = RepositoryProvider.of<ClientRepo>(context);
              return ClientBloc(
                  clientRepo: clientRepo, firebaseUserRepo: userRepository)..add(FetchClient());
            },
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
