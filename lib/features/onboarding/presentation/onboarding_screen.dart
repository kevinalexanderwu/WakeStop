import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/onboarding_item.dart';
import 'widgets/onboarding_footer.dart';
import 'widgets/onboarding_indicator.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastPage => _currentPage == onboardingItems.length - 1;

  void _nextPage() {
    if (_isLastPage) {
      context.go('/auth');
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void _skip() {
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingItems.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPage(
                  item: onboardingItems[index],
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          OnboardingIndicator(
            currentPage: _currentPage,
            totalPages: onboardingItems.length,
          ),

          const SizedBox(height: 20),

          OnboardingFooter(
            isLastPage: _isLastPage,
            onNext: _nextPage,
            onSkip: _skip,
          ),
        ],
      ),
    );
  }
}