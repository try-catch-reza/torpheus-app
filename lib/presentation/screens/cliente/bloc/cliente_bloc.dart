import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/cliente_model.dart';
import '../web/cliente_web_dialog.dart';

part 'cliente_event.dart';

part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  ClienteBloc() : super(const ClienteInitial()) {
    on<ClientesLoad>(_onClientesLoad);
    on<ClienteSelecionar>(_onClienteSelecionar);
  }

  Future<void> _onClientesLoad(
    ClientesLoad event,
    Emitter<ClienteState> emit,
  ) async {
    emit(const ClienteLoading());
    try {
      final List<ClienteModel> mock = [
        const ClienteModel(
          id: '1',
          nome: 'Rafael Mendes',
          cpf: '012.345.678-90',
          telefone: '(49) 99111-2233',
          email: 'rafael@email.com',
          totalVeiculos: 1,
        ),
        const ClienteModel(
          id: '2',
          nome: 'Mariana Souza',
          cpf: '098.765.432-10',
          telefone: '(49) 99222-3344',
          email: 'mariana@email.com',
          totalVeiculos: 1,
        ),
        const ClienteModel(
          id: '3',
          nome: 'Pedro Alves',
          cpf: '111.222.333-44',
          telefone: '(49) 99333-4455',
          email: 'pedro@email.com',
          totalVeiculos: 2,
        ),
        const ClienteModel(
          id: '4',
          nome: 'Fernanda Lima',
          cpf: '222.333.444-55',
          telefone: '(49) 99444-5566',
          email: 'fernanda@email.com',
          totalVeiculos: 1,
        ),
        const ClienteModel(
          id: '5',
          nome: 'João Batista',
          cpf: '333.444.555-66',
          telefone: '(49) 99555-6677',
          email: 'joao@email.com',
          totalVeiculos: 1,
        ),
        const ClienteModel(
          id: '6',
          nome: 'Ana Paula Costa',
          cpf: '444.555.666-77',
          telefone: '(49) 99666-7788',
          email: 'ana@email.com',
          totalVeiculos: 1,
        ),
      ];

      await Future.delayed(const Duration(seconds: 2));

      emit(ClienteLoaded(clientes: mock));
    } catch (e) {
      emit(ClienteError('Não foi possível carregar os clientes\n$e'));
    }
  }

  void _onClienteSelecionar(
    ClienteSelecionar event,
    Emitter<ClienteState> emit,
  ) {
    emit(
      ClienteSelecionado(
        clientes: state.clientes,
        clienteSelecionado: event.cliente,
      ),
    );
  }
}
