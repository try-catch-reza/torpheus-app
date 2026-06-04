import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/loading_state.dart';
import '../bloc/cliente_bloc.dart';
import 'cliente_mobile_body.dart';

class ClienteMobileContent extends StatefulWidget {
  const ClienteMobileContent({super.key});

  @override
  State<ClienteMobileContent> createState() => _ClienteMobileContentState();
}

class _ClienteMobileContentState extends State<ClienteMobileContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ClienteBloc, ClienteState>(
          builder: (context, state) {
            if (state is ClienteLoading) {
              return const LoadingState();
            }

            if (state is ClienteLoaded) {
              return ClienteMobileBody(
                state: state,
                controller: _searchController,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
