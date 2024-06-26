import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr/common/bloc/worker_bloc.dart';

import 'app_view.dart';
import 'common/bloc/client_bloc.dart';
import 'common/data/repositories/client_repo.dart';
import 'common/repo/worker_repo.dart';
import 'features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'features/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'features/auth/data/repository/firebase_user_repo.dart';
import 'features/booking/blocs/cubit/booking_cubit.dart';
import 'features/booking/repository/booking_repository.dart';
import 'features/chat/firebase_provider.dart';
import 'features/home/bloc/most_rated_workers_bloc.dart';
import 'features/home/bloc/search_bloc.dart';
import 'features/home/bloc/services_bloc.dart';
import 'features/home/cubit/subservice_cubit.dart';
import 'features/home/cubit/workerlist_cubit.dart';
import 'features/home/data/data_provider/services_category_data_provider.dart';
import 'features/home/data/data_provider/subservices_data_provider.dart';
import 'features/home/data/data_provider/worker_list_data_provider.dart';
import 'features/home/data/repository/most_rated_workers_repo.dart';
import 'features/home/data/repository/search_repo.dart';
import 'features/home/data/repository/services_category_repo.dart';
import 'features/home/data/repository/subservices_repo.dart';
import 'features/home/data/repository/worker_list_repo.dart';
import 'features/notification/cubit/notification_cubit.dart';
import 'features/notification/repository/notification_repo.dart';

class MyApp extends StatelessWidget {
  final FirebaseUserRepo userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WorkerRepo()),
        RepositoryProvider<BookingRepository>(
          create: (context) => BookingRepository(),
        ),
        RepositoryProvider<NotificationRepo>(
            create: (context) => NotificationRepo()),
        RepositoryProvider<ClientRepo>(
          create: (context) => ClientRepo(),
        ),
        RepositoryProvider<MostRatedWorkersRepo>(
            create: (context) => MostRatedWorkersRepo()),
        RepositoryProvider<ServicesRepo>(
          create: (context) => ServicesRepo(ServicesCategoryProvider()),
        ),
        RepositoryProvider<SearchRepo>(create: (context) => SearchRepo()),
        RepositoryProvider<SubservicesRepo>(
          create: (context) => SubservicesRepo(SubservicesCategoryProvider()),
        ),
        RepositoryProvider<WorkerListRepo>(
          create: (context) => WorkerListRepo(WorkerListDataProvider()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WorkerBloc(workerRepository: RepositoryProvider.of<WorkerRepo>(context))),
          BlocProvider(create: (context) => BookingCubit()..getBookingsById()),
          BlocProvider<NotificationCubit>(
            create: (context) {
              return NotificationCubit(
                RepositoryProvider.of<NotificationRepo>(context),
              );
            },
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository),
          ),
          BlocProvider(
            create: (context) => SignInBloc(userRepository: userRepository),
          ),
          BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(userRepository: userRepository)),
          BlocProvider<ServicesBloc>(create: (context) {
            final servicesCategoryRepo =
                RepositoryProvider.of<ServicesRepo>(context);
            return ServicesBloc(servicesRepo: servicesCategoryRepo)
              ..add(LoadServices());
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
                  clientRepo: clientRepo, firebaseUserRepo: userRepository)
                ..add(FetchClient());
            },
          ),
          BlocProvider<SubserviceCubit>(create: (context) {
            final subservicesRepo =
                RepositoryProvider.of<SubservicesRepo>(context);
            return SubserviceCubit(
              subservicesRepo,
            );
          }),
          BlocProvider<WorkerlistCubit>(create: (context) {
            final workerListRepo =
                RepositoryProvider.of<WorkerListRepo>(context);
            return WorkerlistCubit(workerListRepo);
          }),
        ],
        child: ChangeNotifierProvider(
            create: (_) => FirebaseProvider(), child: const MyAppView()),
      ),
    );
  }
}
