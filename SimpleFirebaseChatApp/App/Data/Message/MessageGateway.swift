//
//  MessageGateway.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol MessageGatewayProtocol {
    func fetchMessageAll(chatRoomDocumentId: String,
                         completion: @escaping ([Message]) -> Void)
    func createMessage(message: Message,
                       chatRoomDocumentId: String,
                       completion: @escaping([Message]) -> Void)
}

class MessageGateway {

    var messageUseCase: MessageUsecaseProtocol!
    var dataStore: MessageDataStore!

    init(messageUseCase: MessageUsecaseProtocol) {
        self.messageUseCase = messageUseCase
    }

}

extension MessageGateway: MessageGatewayProtocol {
    func fetchMessageAll(chatRoomDocumentId: String, completion: @escaping ([Message]) -> Void) {
        self.dataStore.fetchMessageAll(chatRoomDocumentId: chatRoomDocumentId) { messages in
            completion(messages)
        }
    }

    func createMessage(message: Message,
                       chatRoomDocumentId: String, completion: @escaping ([Message]) -> Void) {
        self.dataStore
            .createMessage(message: message,
                        chatRoomDocumentId: chatRoomDocumentId) { messages in
            completion(messages)
        }
    }

    
}
