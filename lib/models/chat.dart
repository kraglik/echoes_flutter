import 'package:echoes/store/store.dart';

class Chat {

  final int id;
  final Map data;
  final String type;
  final Map<int, List<int>> messagesChunks;
  final int mainChunk;
  final int currentChunk;
  final List<int> pending;
  final Set<int> members;


  const Chat({
    this.id,
    this.data,
    this.type,
    this.messagesChunks,
    this.members,
    this.pending,
    this.currentChunk,
    this.mainChunk
  });

  String name(AppState state) {
    if (type == 'dialog') {
      int userId = state.auth.id;
      int otherUserId = members.firstWhere((id) => id != userId);

      return state.users.byId[otherUserId].name;
    }
    else {
      return data['name'];
    }
  }

  static Chat from(data) {
    return new Chat(
        mainChunk: 0,
        messagesChunks: {
          0: [data['last_message']['id']]
        },
        currentChunk: 0,
        id: data['id'],
        type: data['type'],
        members: Set.from(data['members'].map((m) => m['id'])),
        data: data['data'],
        pending: []
    );
  }
}
