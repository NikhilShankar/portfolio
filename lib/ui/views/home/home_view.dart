import 'package:flutter/material.dart';
import 'package:portfolio/ui/widgets/optionb/MainContent.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      HomeViewModel viewModel,
      Widget? child,
      ) {
    return const MainContent();
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel();


}
