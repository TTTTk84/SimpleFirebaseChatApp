//
//  Message.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation
import Firebase

class Message {

    let name: String
    let message: String
    let createdAt: Timestamp

    var userId: String?

    init(dic: [String: Any]) {
        self.name = dic["name"] as? String ?? ""
        self.message = dic["message"] as? String ?? ""
        self.userId = dic["userId"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }

}
