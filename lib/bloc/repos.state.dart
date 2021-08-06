import 'package:repos_search_bloc/enums/enums.dart';
import 'package:repos_search_bloc/model/repo.dart';
import 'package:repos_search_bloc/model/repository.model.dart';

class ReposState{
  List<Repo> repos;
  RequestState requestState;
  String errorMsg;

  ReposState({this.repos, this.requestState, this.errorMsg});

  // constructeur nommé
  ReposState.initialState():
        repos = [],
        requestState= RequestState.NONE,
        errorMsg= '';
}
