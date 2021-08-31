//
//  UserDataStore.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation


protocol UserDataStoreProtocol {
    func fetchAll(completion: ([User]) -> Void)
}

class UserDataStore {

    var tempUserArray: [User] = [
        User(dic: ["username": "user 1"]),
        User(dic: ["username": "user 2"]),
        User(dic: ["username": "user 3"]),
        User(dic: ["username": "user 4"]),
    ]

    init() {
    }

}

extension UserDataStore: UserDataStoreProtocol {
    func fetchAll(completion: ([User]) -> Void) {
        completion(self.tempUserArray)
    }

}
