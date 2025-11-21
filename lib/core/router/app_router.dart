import 'package:car_rental_app/features/auth/screens/login_screen.dart';
import 'package:car_rental_app/features/bookings/models/booking_model.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/features/bookings/screens/bookings_screen.dart';
import 'package:car_rental_app/features/cars/models/car_model.dart';
import 'package:car_rental_app/features/cars/screens/car_details_screen.dart';
import 'package:car_rental_app/features/cars/screens/cars_list_screen.dart';
import 'package:car_rental_app/features/cars/screens/favorites_screen.dart';
import 'package:car_rental_app/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// AppState is now adapted to the project, providing booking state.
class AppState extends InheritedWidget {
  const AppState({
    super.key,
    required this.bookings,
    required this.addBooking,
    required super.child,
  });

  final List<BookingModel> bookings;
  final void Function(BookingModel) addBooking;

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    // Notify listeners only if the bookings list instance has changed.
    return bookings != oldWidget.bookings;
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // The state management logic is now here.
  List<BookingModel> _bookings = [];

  void _addBooking(BookingModel booking) {
    setState(() {
      _bookings = [..._bookings, booking];
    });
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      bookings: _bookings,
      addBooking: _addBooking,
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car), label: 'Cars'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (_, __) => '/login',
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),

    // The ShellRoute now uses the stateful MainScreen as its builder.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        // The first branch, for the 'Cars' tab.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/main',
              builder: (context, state) => CarsListScreen(),
              routes: [
                GoRoute(
                  path: 'car-details', // Full path: /main/car-details
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final car = state.extra as CarModel;
                    return CarDetailsScreen(car: car);
                  },
                ),
                GoRoute(
                  path: 'booking-form', // Full path: /main/booking-form
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final car = state.extra as CarModel;
                    return BookingFormScreen(car: car);
                  },
                ),
              ],
            ),
          ],
        ),

        // The second branch, for the 'Favorites' tab.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),

        // The third branch, for the 'Bookings' tab.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookings',
              builder: (context, state) => const BookingsScreen(),
            ),
          ],
        ),

        // The fourth branch, for the 'Profile' tab.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
