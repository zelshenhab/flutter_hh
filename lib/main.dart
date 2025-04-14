import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hh/core/constants/app_strings.dart';
import 'package:flutter_hh/core/theme/app_theme.dart';
import 'package:flutter_hh/features/auth/logic/auth_provider.dart';
import 'package:flutter_hh/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_hh/features/auth/presentation/screens/personal_info_screen.dart';
import 'package:flutter_hh/features/chat/logic/chat_provider.dart';
import 'package:flutter_hh/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:flutter_hh/features/home/logic/home_provider.dart';
import 'package:flutter_hh/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_hh/features/hunting_mode/logic/hunting_provider.dart';
import 'package:flutter_hh/features/hunting_mode/presentation/screens/hunting_screen.dart';
import 'package:flutter_hh/features/partner_profile/logic/partner_provider.dart';
import 'package:flutter_hh/features/profile/logic/profile_provider.dart';
import 'package:flutter_hh/features/subscription/logic/subscription_provider.dart';
import 'package:flutter_hh/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:flutter_hh/features/onboarding/logic/onboarding_provider.dart';
import 'package:flutter_hh/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => HuntingProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => PartnerProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const OnboardingScreen(),
        '/register': (_) => const LoginScreen(),
        '/personal-info': (_) => const PersonalInfoScreen(),
        '/home': (_) => const HomeScreen(),
        '/hunting': (_) => HuntingScreen(),
        '/chat': (_) => const ChatListScreen(),
        '/subscription': (_) => const SubscriptionScreen(),
      },
    );
  }
}
