//
//  User.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import Foundation
import Firebase

class User {
    let email: String
    let username: String
    let createdAt: Timestamp
    let profileImageUrl: String
    
    var documentId: String?


    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
    }
}
