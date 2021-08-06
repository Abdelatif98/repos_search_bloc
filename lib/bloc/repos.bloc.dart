import 'package:bloc/bloc.dart';
import 'package:repos_search_bloc/bloc/repos.event.dart';
import 'package:repos_search_bloc/bloc/repos.state.dart';
import 'package:repos_search_bloc/enums/enums.dart';
import 'package:repos_search_bloc/model/repo.dart';
import 'package:repos_search_bloc/model/repository.model.dart';
import 'package:repos_search_bloc/services/repos.api.dart';
import 'package:repos_search_bloc/services/repos.service.dart';

class ReposBloc extends Bloc<ReposEvent,ReposState>{

  ReposBloc({ReposState initialState}) : super(initialState);


  @override
  Stream<ReposState> mapEventToState(ReposEvent event) async*{
    if(event is GetReposEvent){
      yield ReposState(repos: state.repos, requestState: RequestState.LOADING);

      try {
        List<Repo> repos = await Api.getRepositories(event.payload);
        yield ReposState(repos: repos, requestState: RequestState.LOADED);
      } catch (e) {
        yield ReposState(repos: state.repos, requestState: RequestState.ERROR, errorMsg: 'internal error');
      }
    }
  }
}