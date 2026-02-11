import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_template/presentation/home/pages/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(create: (_) => sl(), child: HomeView());
  }
}
