import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/global.dart';
import '../../data/cache helper.dart';
import '../cubit/cubit.dart';
import 'onboarding.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.translate_rounded, size: 80, color: Colors.indigo),
              const SizedBox(height: 20),
              Text(
                S.of(context).chooseLanguage,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              Text(
                S.of(context).chooseLanguageAr,
                style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              const SizedBox(height: 50),
              _buildLanguageButton(
                context, 
                title: "English", 
                subtitle: "Default", 
                langCode: 'en'
              ),
              const SizedBox(height: 20),
              _buildLanguageButton(
                context, 
                title: "العربية", 
                subtitle: "Arabic", 
                langCode: 'ar'
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, {required String title, required String subtitle, required String langCode}) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 2,
        ),
        onPressed: () async {
          // Use HomeCubit to set language, persist it, and emit state
          await HomeCubit.get(context).setLanguage(langCode);
          if (context.mounted) {
            navigateAndFinish(context, const OnBoardingScreen());
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.7))),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}
