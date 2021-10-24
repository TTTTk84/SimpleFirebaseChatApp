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

        userUseCase.getLoginUser() { user in
            self.currentUser = user
        }
        self.partnerUser = chatroom.partnerUser
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
    }


}

