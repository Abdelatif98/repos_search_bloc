import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_search_bloc/bloc/repos.bloc.dart';
import 'package:repos_search_bloc/bloc/repos.event.dart';
import 'package:repos_search_bloc/bloc/repos.state.dart';
import 'package:repos_search_bloc/enums/enums.dart';
import 'package:repos_search_bloc/pages/widgets/repos.list.item.dart';
import 'package:loading_animations/loading_animations.dart';

class ReposPage extends StatefulWidget {
  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  ScrollController _scrollController = new ScrollController();
  int itemSize = 0;
  bool showBtn = false;

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ++_currentPage;
        context.read<ReposBloc>().add(GetReposEvent(_currentPage));
      }/*else if(_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent && _currentPage != 1){
        --_currentPage;
        context.read<ReposBloc>().add(GetReposEvent(_currentPage));
      }*/
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ReposBloc>().add(GetReposEvent(_currentPage));
    return Scaffold(
      appBar: AppBar(
        title: Text('Repos', style: TextStyle(color: Colors.white),),
      ),
      body: Center(child: BlocBuilder<ReposBloc, ReposState>(builder: (context, state) {
          if(state.requestState == RequestState.LOADING){
            return LoadingBouncingGrid.circle( size: 140, backgroundColor: Colors.cyan,);
          }else if(state.requestState == RequestState.ERROR){
            print(state.errorMsg);
            return Container();
          }else if (state.requestState == RequestState.LOADED){
            showBtn = true;
            itemSize = state.repos.length;
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if(notification is ScrollUpdateNotification){
                  _onIUpdateScroll(notification.metrics);
                }
                return true;
              },
              child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: (state.repos != null)?state.repos.length:0,
                  itemBuilder: (BuildContext context, int index) {
                    return GithubItem(state.repos[index]);
                  }),
            );
          }
          else return Container();
        },),
      ),
      floatingActionButton: BlocBuilder<ReposBloc, ReposState>(builder: (context, state) {
        if (state.requestState == RequestState.LOADED){
          return FloatingActionButton(
            onPressed: () {
              _moveUp();
            },
            child: const Icon(Icons.navigation, color: Colors.white),
            backgroundColor: Colors.cyan,
          );
        }else return Container();
      }
      ),
    );
  }

  void _onIUpdateScroll(ScrollMetrics metrics) {
    if(_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent && _currentPage != 1){
      --_currentPage;
      context.read<ReposBloc>().add(GetReposEvent(_currentPage));
    }
  }

  _moveUp() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent + 10 ,
        curve: Curves.linear, duration: Duration(milliseconds: 200));
  }

}
