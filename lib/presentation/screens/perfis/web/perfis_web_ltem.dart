import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/perfis_model.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_bloc.dart';
import 'package:torpheus/presentation/screens/perfis/bloc/perfis_state.dart';

class PerfisWebItem extends StatelessWidget {
  const PerfisWebItem({
    super.key,
    required this.perfis,
    required this.onTap,
    required this.isSelected,
  });

  final PerfisModel perfis;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfisBloc, PerfisState>(
      builder: (context, state) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : ColorConstants.zhenZhuBaiPearl,
              border: Border(
                left: BorderSide(
                  color: isSelected
                      ? ColorConstants.chambray
                      : ColorConstants.zhenZhuBaiPearl,
                  width: 2,
                ),
                bottom: const BorderSide(color: ColorConstants.mercury),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: const BoxDecoration(
                    color: ColorConstants.zhenZhuBaiPearl,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    size: 20,
                    color: ColorConstants.chambray,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    perfis.nome ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.chromaphobicBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
