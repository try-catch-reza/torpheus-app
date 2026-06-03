import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/veiculo_model.dart';

class VeiculosMobileCard extends StatelessWidget {
  const VeiculosMobileCard({
    super.key,
    required this.veiculo,
    required this.onTap,
  });

  final VeiculoModel? veiculo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 22.0,
        left: 22.0,
        bottom: 10.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  '${veiculo?.placa}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: ColorConstants.chromaphobicBlack,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                        right: 20.0,
                      ),
                      child: Text(
                        veiculo?.subTitle ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: ColorConstants.shadowMountain,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18.0,
                    color: ColorConstants.chambray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
