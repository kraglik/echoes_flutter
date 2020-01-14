class CreateDialog {

  final String nickname;

  const CreateDialog({
    this.nickname
  });

}

class DialogCreated {

}

class FindSimilar {

  final String nickname;

  const FindSimilar({
    this.nickname
  });

}

class SimilarLoaded {
  final List<int> ids;

  const SimilarLoaded({this.ids});
}