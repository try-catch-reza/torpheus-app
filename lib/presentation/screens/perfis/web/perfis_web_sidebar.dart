import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_event.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';
import 'package:torpheus/presentation/screens/perfis/web/perfis_web_ltem.dart';

class PerfisWebSidebar extends StatelessWidget {
  const PerfisWebSidebar({
    super.key,
    required this.perfis,
    required this.onNewProfile,
  });

  final List<PerfisModel> perfis;
  final VoidCallback onNewProfile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfisBloc, PerfisState>(
      builder: (context, state) {
        return Container(
          width: 272,
          decoration: const BoxDecoration(
            color: ColorConstants.zhenZhuBaiPearl,
            border: Border(right: BorderSide(color: ColorConstants.mercury)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.mercury,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${perfis.length} Perfis',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.chromaphobicBlack,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: onNewProfile,
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Novo'),
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorConstants.chambray,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: perfis.length,
                  itemBuilder: (context, index) {
                    final perfil = perfis[index];

                    return PerfisWebItem(
                      perfis: perfil,
                      isSelected: perfil.id == state.perfilSelecionado?.id,
                      onTap: () => _onPerfilTap(context, perfil.id ?? ''),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onPerfilTap(BuildContext context, String id) {
    context.read<PerfisBloc>().add(PerfisSelect(id));
  }
}
