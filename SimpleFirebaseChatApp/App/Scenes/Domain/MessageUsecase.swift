//
//  messageUsecase.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/10/03.
//

import Foundation


protocol MessageUsecaseProtocol {
    func fetchMessageAll(chatRoomDocumentId: String)
    func createMessage(message: Message,
                       chatRoomDocumentId: String)

    var messageGateway: MessageGatewayProtocol! { get set }
    var chatRoomOutput: MessageUsecaseChatRoomOutput! { get set }
}

protocol MessageUsecaseChatRoomOutput {
    func useCaseDidUpdate(messages: [Message])
}

class MessageUsecase {

    var messageGateway: MessageGatewayProtocol!
    var chatRoomOutput: MessageUsecaseChatRoomOutput!

    private(set) var messages: [Message] = []

    init() {}
}

extension MessageUsecase: MessageUsecaseProtocol {

    func fetchMessageAll(chatRoomDocumentId: String) {
        self.messageGateway.fetchMessageAll(chatRoomDocumentId: chatRoomDocumentId) { messages in
            self.messages = messages
            self.chatRoomOutput.useCaseDidUpdate(messages: messages)
        }
    }

    func createMessage(message: Message,
                       chatRoomDocumentId: String) {
        self.messageGateway
            .createMessage(message: message,                                        chatRoomDocumentId: chatRoomDocumentId) { messages in
            self.messages = messages
            self.chatRoomOutput.useCaseDidUpdate(messages: messages)
        }
    }
}
