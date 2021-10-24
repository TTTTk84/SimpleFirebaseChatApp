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
    var members: [String]
    var chatRoomName: String
    let createdAt: Timestamp
    var partnerUser: User?

    var documentId: String?

    init(dic: [String: Any]) {
        self.latestMessageId = dic["latestMessageId"] as? String ?? ""
        self.members = dic["members"] as? [String] ?? [String]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.chatRoomName = dic["chatRoomName"] as? String ?? ""
    }

}
