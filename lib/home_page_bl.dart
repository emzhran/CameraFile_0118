import 'package:camera_118/bloc/camera_bloc.dart';
import 'package:camera_118/bloc/camera_event.dart';
import 'package:camera_118/bloc/camera_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBl extends StatelessWidget {
  const HomePageBl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: SafeArea(
        child: BlocConsumer<CameraBloc, CameraState>(
          listener: (context, state) {
            if (state is CameraReady && state.snackBarMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.snackBarMessage!)));
              context.read<CameraBloc>().add(ClearSnackbar());
            }
          },
          builder: (context, state) {},
        ),
      ),
    );
  }
}
