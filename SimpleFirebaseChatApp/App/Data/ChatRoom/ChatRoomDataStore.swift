//
//  ChatRoomDataStore.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol ChatRoomDataStoreProtocol {
    func fetchAll(completion: ([ChatRoom]) -> Void)
}


class ChatRoomDataStore {

    var tempChatRoomArray: [ChatRoom] = [
        ChatRoom(dic: ["latestMessageId": "message1",
                       "chatRoomName": "chatroom 1"]),
        ChatRoom(dic: ["latestMessageId": "message2",
                       "chatRoomName": "chatroom 2"]),
        ChatRoom(dic: ["latestMessageId": "message3",
                       "chatRoomName": "chatroom 3"]),
    ]

    init(){
    }

}

extension ChatRoomDataStore: ChatRoomDataStoreProtocol {
    func fetchAll(completion: ([ChatRoom]) -> Void) {
        completion(self.tempChatRoomArray)
    }

}
