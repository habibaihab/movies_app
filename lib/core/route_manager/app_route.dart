import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/route_manager/route_names.dart';
import 'package:movies_app/features/browse/presentation/manager/genres_movies/genres_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/pages/browse_screen.dart';
import 'package:movies_app/features/home/presentation/manager/new_releases_movies/new_releases_cubit.dart';
import 'package:movies_app/features/home/presentation/manager/popular_movies/get_movies_cubit.dart';
import 'package:movies_app/features/home/presentation/manager/up_coming_movies/up_coming_cubit.dart';
import 'package:movies_app/features/home/presentation/pages/home_screen.dart';
import 'package:movies_app/features/layout/presentation/pages/layout_screen.dart';
import 'package:movies_app/features/search/presentation/manager/search_movies/search_cubit.dart';
import 'package:movies_app/features/search/presentation/pages/search_screen.dart';
import 'package:movies_app/features/watch_list/presentation/manager/watch_list/watch_list_cubit.dart';
import 'package:movies_app/features/watch_list/presentation/pages/watch_list_screen.dart';

import '../../features/splash/presentation/pages/splash_screen.dart';

final GoRouter appRoute = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocProvider(
          create: (context) => WatchListCubit(),
          child: LayoutScreen(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.home,
              builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => GetMoviesCubit()),
                  BlocProvider(create: (context) => NewReleasesCubit()),
                  BlocProvider(create: (context) => UpComingCubit()),
                ],
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.search,
              builder: (context, state) => BlocProvider(
                create: (context) => SearchCubit(),
                child: const SearchScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.browseScreen,
              builder: (context, state) => BlocProvider(
                create: (context) => GenresMoviesCubit(),
                child: const BrowseScreen(),

              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.watchList,
              builder: (context, state) => const WatchListScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
