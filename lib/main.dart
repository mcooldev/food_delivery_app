import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/providers/auth_provider.dart';
import 'package:food_delivery_app/providers/cart_provider.dart';
import 'package:food_delivery_app/providers/category_provider.dart';
import 'package:food_delivery_app/providers/checkout_provider.dart';
import 'package:food_delivery_app/providers/choose_location_provider.dart';
import 'package:food_delivery_app/providers/maps_provider.dart';
import 'package:food_delivery_app/providers/onboarding_provider.dart';
import 'package:food_delivery_app/providers/orders_provider.dart';
import 'package:food_delivery_app/providers/payment_method_provider.dart';
import 'package:food_delivery_app/providers/products_provider.dart';
import 'package:food_delivery_app/screens/cart.dart';
import 'package:food_delivery_app/screens/checkout.dart';
import 'package:food_delivery_app/screens/home.dart';
import 'package:food_delivery_app/screens/log_in.dart';
import 'package:food_delivery_app/screens/maps_screen.dart';
import 'package:food_delivery_app/screens/my_account.dart';
import 'package:food_delivery_app/screens/my_orders.dart';
import 'package:food_delivery_app/screens/onboarding.dart';
import 'package:food_delivery_app/screens/order_detail.dart';
import 'package:food_delivery_app/screens/receipt_screen.dart';
import 'package:food_delivery_app/screens/sign_up.dart';
import 'package:food_delivery_app/screens/single_product.dart';
import 'package:food_delivery_app/screens/support_chat.dart';
import 'package:food_delivery_app/services/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await Supabase.initialize(
    url: "https://pnjyfphihmfmqnajwwtq.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBuanlmcGhpaG1mbXFuYWp3d3RxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgyNzAzMTEsImV4cCI6MjA2Mzg0NjMxMX0.qvvG8j6DbQff-NTpIwSMgNRNVeaQC2VJiLGjEYX2sz0",
  );
  //
  await dotenv.load(fileName: ".env");
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => CategoryProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => CheckoutProvider()),
        ChangeNotifierProvider(create: (ctx) => PaymentMethodProvider()),
        ChangeNotifierProvider(create: (ctx) => ChooseLocationProvider()),
        ChangeNotifierProvider(create: (ctx) => MapsProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'MyFood',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: darkPurple,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          colorScheme: ColorScheme.fromSeed(seedColor: darkPurple),
        ),
        initialRoute: '/onBoarding',
        routes: {
          '/onBoarding': (context) => const Onboarding(),
          '/home': (context) => const Home(),
          '/signUp': (context) => const SignUp(),
          '/logIn': (context) => const LogIn(),
          '/singleProduct': (context) => const SingleProduct(),
          '/cart': (context) => const Cart(),
          '/checkout': (context) => const Checkout(),
          '/authGate': (context) => const AuthGate(),
          '/myAccount': (context) => const MyAccount(),
          '/mapsScreen': (context) => const MapsScreen(),
          '/receipt': (context) => const ReceiptScreen(),
          '/supportChat': (context) => const SupportChat(),
          '/myOrders': (context) => const MyOrders(),
          '/orderDetails': (context) => const OrderDetail(),
        },
      ),
    );
  }
}
