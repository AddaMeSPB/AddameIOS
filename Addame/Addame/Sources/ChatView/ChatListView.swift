//
//  ChatListView.swift
//  
//
//  Created by Saroar Khandoker on 17.06.2021.
//

import ComposableArchitecture
import SwiftUI
import SharedModels

struct ChatListView: View {
  let store: Store<ChatState, ChatAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      ForEachStore(
        self.store.scope(state: \.messages, action: ChatAction.message)
      ) { chatStore in
        WithViewStore(chatStore) { messageViewStore in
          ChatRowView(store: chatStore)
            .onAppear {
              viewStore.send(.fetchMoreMessagIfNeeded(currentItem: messageViewStore.state) )
            }
        }
      }
    }
  }
}