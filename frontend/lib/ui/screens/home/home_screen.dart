import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:frontend/ui/screens/cart/cart_screen.dart';
import 'package:frontend/ui/screens/home/category_screen.dart';
import 'package:frontend/ui/screens/home/profile_screen.dart';
import 'package:frontend/ui/screens/home/user_feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> currentScreen = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          }, icon: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
            return Badge(
                label: Text("${state.items.length}"),
                isLabelVisible: (state is CartLoadingState) ? false : true,
                child: const Icon(CupertinoIcons.cart_fill));
          })),
        ],
      ),
      body: currentScreen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        elevation: 0.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
