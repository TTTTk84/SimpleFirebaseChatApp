//
//  ChatRoom.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation
import Firebase

class ChatRoom {

    var latestMessageId: String
    var memebers: [User]
    var chatRoomName: String
    let createdAt: Timestamp

    var documentId: String?

    init(dic: [String: Any]) {
        self.latestMessageId = dic["latestMessageId"] as? String ?? ""
        self.memebers = dic["memebers"] as? [User] ?? [User]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.chatRoomName = dic["chatRoomName"] as? String ?? ""
    }

}
