abstract class ReposEvent<T>{
  T payload;

  ReposEvent(this.payload);
}

class GetReposEvent extends ReposEvent<int>{
  GetReposEvent(int payload) : super(payload);
}