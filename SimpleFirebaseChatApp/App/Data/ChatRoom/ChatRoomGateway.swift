//
//  ChatRoomGateway.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation




protocol ChatRoomGatewayProtocol {
    func fetchAll(completion: ([ChatRoom]) -> Void)
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
        dataStore.fetchAll() { [weak self] chatRoomList in
            guard self != nil else { return }
            completion(chatRoomList)
        }
    }
}
