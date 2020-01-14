import 'package:echoes/store/actions/dialog_creation.dart';

class DialogCreationState {

  final List<int> usersLike;
  final bool loading;
  final bool error;
  final String pattern;

  const DialogCreationState({
    this.usersLike,
    this.pattern,
    this.loading,
    this.error
  });

}


DialogCreationState dialogCreationReducer(DialogCreationState state, dynamic action) {

  if (action is FindSimilar) {
    return new DialogCreationState(
      usersLike: state.usersLike,
      pattern: action.nickname,
      loading: state.loading,
      error: state.error
    );
  }

  if (action is SimilarLoaded) {
    return new DialogCreationState(
      usersLike: action.ids,
      pattern: state.pattern,
      loading: state.loading,
      error: state.error
    );
  }

  if (action is CreateDialog) {
    return new DialogCreationState(
      usersLike: state.usersLike,
      pattern: state.pattern,
      loading: true,
      error: false
    );
  }

  if (action is DialogCreated) {
    return initialDialogCreationState;
  }

  return state;
}

final initialDialogCreationState = new DialogCreationState(
  usersLike: [],
  pattern: '',
  loading: false,
  error: false
);
