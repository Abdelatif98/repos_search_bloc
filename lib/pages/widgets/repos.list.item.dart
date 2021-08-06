import 'package:flutter/material.dart';
import 'package:repos_search_bloc/model/repo.dart';

class GithubItem extends StatelessWidget {
  final Repo repo;
  GithubItem(this.repo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(repo.name)),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text((repo.description != null)?repo.description:'no description')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Text((repo.owner != null)?repo.owner:'', textAlign: TextAlign.start,)),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.yellow,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(repo.watchersCount.toString()),
                              )
                            ]
                        )
                    ),
                    Expanded(child: Text((repo.language != null)?repo.language:'', textAlign: TextAlign.end, style: Theme.of(context).textTheme.caption,))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}