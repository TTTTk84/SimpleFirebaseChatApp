//
//  UserDataStore.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation
import Firebase

protocol UserDataStoreProtocol {
    func getLoginUser(completion: @escaping (User) -> Void)
    func fetchAll(completion: @escaping ([User]) -> Void)
}

class UserDataStore {

    var tempUserArray: [User] = [
        User(dic: ["username": "user 1"]),
        User(dic: ["username": "user 2"]),
        User(dic: ["username": "user 3"]),
        User(dic: ["username": "user 4"]),
    ]

    var users: [User] = []

    init() {
    }

}

extension UserDataStore: UserDataStoreProtocol {
    func getLoginUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("uid: \(uid)")

        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗しました。\(err)")
                return
            }

            guard let snapshot = snapshot, let dic = snapshot.data() else { return }

            let user = User(dic: dic)
            completion(user)
        }
    }

    func fetchAll(completion: @escaping ([User]) -> Void) {
        Firestore.firestore().collection("users").getDocuments {
            (snapshots, err) in
            self.users = []
            if err != nil {
                print("userの情報の取得に失敗しました")
                return
            }


            snapshots?.documents.forEach({ (snapshot) in
                let dic = snapshot.data()
                let user = User(dic: dic)
                user.documentId = snapshot.documentID

                guard let documentId = Auth.auth().currentUser?.uid else { return }
                if documentId == snapshot.documentID {
                    return
                }

                self.users.append(user)
                completion(self.users)
            })
        }
    }

}
