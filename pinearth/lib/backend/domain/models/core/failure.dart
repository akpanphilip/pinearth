abstract class IFailure {
  String message;
  IFailure(this.message);
}


class RepoFailure implements IFailure {
  @override
  String message;
  RepoFailure(this.message);
}