//
//  ChatRoomGateway.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation




protocol ChatRoomGatewayProtocol {
    func fetchAll(completion: ([ChatRoom]) -> Void)
    func createChatRoom(chatRoom: ChatRoom, completion: ([ChatRoom]) -> Void)
}

class ChatRoomGateway {

    var useCase: ChatUseCaseProtocol!
    var dataStore: ChatRoomDataStoreProtocol!

    init(useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension ChatRoomGateway: ChatRoomGatewayProtocol {






    func fetchAll(completion: ([ChatRoom]) -> Void) {

        self.dataStore.fetchAll() { [weak self] chatRoomList in
            guard self != nil else { return }
            completion(chatRoomList)
        }
    }

    func createChatRoom(chatRoom: ChatRoom, completion: ([ChatRoom]) -> Void) {

        self.dataStore.createChatRoom(chatRoom: chatRoom) {
            [weak self] chatRoomList in
            guard self != nil else { return }
            completion(chatRoomList)
        }
    }

}
