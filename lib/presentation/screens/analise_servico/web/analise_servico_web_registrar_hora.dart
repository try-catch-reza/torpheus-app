import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/presentation/components/app_dropdown_field.dart';
import 'package:torpheus/presentation/components/app_text_field.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

class AnaliseServicoWebRegistrarHora extends StatelessWidget {
  const AnaliseServicoWebRegistrarHora({
    super.key,
    required this.horaController,
    required this.minutoController,
    required this.notaController,
    required this.state,
    required this.formKey,
  });

  final TextEditingController horaController;
  final TextEditingController minutoController;
  final TextEditingController notaController;
  final AnaliseServicoState state;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Registrar hora',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ColorConstants.chambray,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Registre as horas gastas na execução do serviço.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            AppDropdownField(
              label: 'Funcionários',
              items: state.funcionarios.map((funcionario) {
                return DropdownMenuItem(
                  value: funcionario,
                  child: Text(funcionario.nome ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                context.read<AnaliseServicoBloc>().add(
                      AnaliseServicoSetFuncionario(funcionario: value!),
                    );
              },
            ),
            const SizedBox(height: 16),
            _DatePickerBox(
              onTap: () => _selecionarData(context),
              label: 'Data',
              valor: _formatarData(state.data),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: AppTextField(
                      keyboardType: TextInputType.number,
                      label: 'Horas',
                      controller: horaController,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: AppTextField(
                      label: 'Minutos',
                      controller: minutoController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: notaController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              label: 'Oque foi feito',
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _onPressed(context),
                  label: const Text('Registrar hora'),
                  icon: const Icon(
                    Icons.check,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatarData(DateTime? data) {
    if (data == null) return 'dd/mm/aaaa';
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  void _onPressed(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final bloc = context.read<AnaliseServicoBloc>();
      final horas = int.tryParse(horaController.text) ?? 0;
      final minutos = int.tryParse(minutoController.text) ?? 0;
      final nota = notaController.text;

      bloc.add(
        AnaliseServicoRegistrarHora(
          hora: horas.toString(),
          minuto: minutos.toString(),
          nota: nota,
        ),
      );
    }
  }

  Future<void> _selecionarData(BuildContext context) async {
    final bloc = context.read<AnaliseServicoBloc>();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B2A4A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1B2A4A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    bloc.add(AnaliseServicoSetData(data: picked));
  }
}

class _DatePickerBox extends StatelessWidget {
  final String label;
  final String valor;
  final VoidCallback onTap;

  const _DatePickerBox({
    required this.label,
    required this.valor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE8ECF0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label  ',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ColorConstants.chromaphobicBlack,
                letterSpacing: 0.4,
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 14,
              color: Color(
                0xFF1B2A4A,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              valor,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2A4A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
