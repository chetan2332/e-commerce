import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/model/category/category_model.dart';
import 'package:frontend/data/model/product/product_model.dart';
import 'package:frontend/logic/cubits/category_product_cubit.dart/category_product_cubit.dart';
import 'package:frontend/ui/screens/auth/login_screen.dart';
import 'package:frontend/ui/screens/auth/provider/login_provider.dart';
import 'package:frontend/ui/screens/auth/provider/signup_provider.dart';
import 'package:frontend/ui/screens/auth/signup_screen.dart';
import 'package:frontend/ui/screens/cart/cart_screen.dart';
import 'package:frontend/ui/screens/home/home_screen.dart';
import 'package:frontend/ui/screens/order/my_order_screen.dart';
import 'package:frontend/ui/screens/order/order_detail_screen.dart';
import 'package:frontend/ui/screens/order/order_placed_screen.dart';
import 'package:frontend/ui/screens/order/provider/order_detail_provider.dart';
import 'package:frontend/ui/screens/product/category_product_screen.dart';
import 'package:frontend/ui/screens/product/product_detail_screen.dart';
import 'package:frontend/ui/screens/splash/splash_screen.dart';
import 'package:frontend/ui/screens/users/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => LoginProvider(context),
            child: const LoginScreen(),
          ),
        );

      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignUpProvider(context),
            child: const SignUpScreen(),
          ),
        );

      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case CartScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailsScreen(
              productModel: settings.arguments as ProductModel),
        );

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EditProfileScreen(),
        );

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CategoryProductCubit(settings.arguments as CategoryModel),
            child: const CategoryProductScreen(),
          ),
        );

      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => OrderDetailProvider(),
            child: const OrderDetailScreen(),
          ),
        );

      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case MyOrderScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const MyOrderScreen());

      default:
        return null;
    }
  }
}
