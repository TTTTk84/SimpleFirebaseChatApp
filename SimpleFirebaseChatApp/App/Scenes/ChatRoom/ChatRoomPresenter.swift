//
//  ChatRoomPresenter.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation

protocol ChatRoomPresenterProtocol {
    var numberOfUsers: Int { get }
    func tappedSendButton(text: String)
    func checkMessageRow(forRow row: Int) -> Message?

    var currentUser: User! { get set }
    var partnerUser: User! { get set }
}


class ChatRoomPresenter {

    var view: ChatViewProtocol!
    var chatroom: ChatRoom!
    var messageUseCase: MessageUsecaseProtocol!
    private(set) var messages: [Message] = []
    var currentUser: User!
    var partnerUser: User!


    init(view: ChatViewProtocol,
         chatroom: ChatRoom,
         messageUseCase: MessageUsecaseProtocol,
         userUseCase: UserUsecaseProtocol) {
        self.view = view
        self.chatroom = chatroom
        self.messageUseCase = messageUseCase
        self.messageUseCase.chatRoomOutput = self

        userUseCase.getLoginUser() { user in
            self.currentUser = user
        }
        self.partnerUser = chatroom.partnerUser
        self.messageUseCase.fetchMessageAll(chatRoomDocumentId: chatroom.documentId!)
    }
}

extension ChatRoomPresenter: ChatRoomPresenterProtocol {

    var numberOfUsers: Int {
        return self.messages.count
    }

    func checkMessageRow(forRow row: Int) -> Message? {
        guard row < self.messages.count else { return nil }
        return self.messages[row]
    }

    func tappedSendButton(text: String) {
        let name = currentUser.username
        let uid = currentUser.uid
        let message = Message(dic: ["name": name,
                                    "userId": uid,
                                    "message": text])
        guard let chatroom = self.chatroom,
              let documentId = chatroom.documentId else {
                  return
              }

        self.messageUseCase
            .createMessage(message: message,
                           chatRoomDocumentId: documentId)
    }


}

extension ChatRoomPresenter: MessageUsecaseChatRoomOutput {
    func useCaseDidUpdate(messages: [Message]) {
        self.messages = messages
        self.view.reloadTableView()
    }
}
