import 'dart:math';

import 'package:echoes/models/message.dart';
import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/actions/messages.dart';

class MessagesState {

  final Map<int, Message> messages;
  final Map<int, Message> pendingMessages;
  final Map<int, int> reads;
  final int localId;

  const MessagesState({
    this.messages,
    this.pendingMessages,
    this.localId,
    this.reads
  });

}

MessagesState
messageReceivedReducer(MessagesState state, MessageReceived action) {

  var pending = state.pendingMessages;

  if (pending.containsKey(action.message.id)) {
    pending = {}..addAll(state.pendingMessages);
    pending.remove(action.message.id);
  }

  return new MessagesState(
    messages: {
      ...state.messages,
      action.message.id: action.message
    },
    reads: state.reads,
    pendingMessages: pending,
    localId: state.localId,
  );

}

MessagesState
readsUpdateReducer(MessagesState state, MessagesReadsUpdate action) {
  var reads = action.reads;

  reads.removeWhere((key, val) => !state.messages.containsKey(key));

  return new MessagesState(
    messages: state.messages,
    pendingMessages: state.pendingMessages,
    reads: {
      ...state.reads,
      ...reads
    },
    localId: state.localId
  );

}

MessagesState
updateLocalIdReducer(MessagesState state, SendMessage action) {

  return new MessagesState(
    messages: state.messages,
    pendingMessages: state.pendingMessages,
    reads: state.reads,
    localId: state.localId + 1
  );

}

MessagesState
messageUpdatedReducer(MessagesState state, MessageUpdated action) {

  return new MessagesState(
    pendingMessages: state.pendingMessages,
    messages: {...state.messages, action.message.id: action.message},
    reads: {...state.reads, action.message.id: action.message.reads}
  );

}

MessagesState
messageDeletedReducer(MessagesState state, MessageDeleted action) {

  return new MessagesState(
    pendingMessages: state.pendingMessages,
    messages: {...state.messages}..remove(action.messageId),
    reads: {...state.reads}..remove(action.messageId)
  );

}

MessagesState
messagesLoadedReducer(MessagesState state, MessagesLoaded action) {
  return new MessagesState(
    messages: {
      ...state.messages,
      ...action.messages
    },
    reads: {
      ...state.reads,
      ...action.reads
    },
    pendingMessages: state.pendingMessages,
    localId: state.localId
  );
}


MessagesState messagesReducer(MessagesState state, dynamic action) {

  if (action is LogOut)
    return initialMessagesState;

  if (action is MessagesLoaded)
    return messagesLoadedReducer(state, action);

  if (action is MessageReceived)
    return messageReceivedReducer(state, action);

  if (action is MessagesReadsUpdate)
    return readsUpdateReducer(state, action);

  if (action is SendMessage)
    return updateLocalIdReducer(state, action);

  return state;

}

final MessagesState initialMessagesState = new MessagesState(
  messages: {},
  pendingMessages: {},
  localId: 0,
  reads: {}
);
