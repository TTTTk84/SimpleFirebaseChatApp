//
//  ChatRoom.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation
import Firebase

class ChatRoom {

    let latestMessageId: String
    let memebers: [String]
    let createdAt: Timestamp

    var documentId: String?

    init(dic: [String: Any]) {
        self.latestMessageId = dic["latestMessageId"] as? String ?? ""
        self.memebers = dic["memebers"] as? [String] ?? [String]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }

}
