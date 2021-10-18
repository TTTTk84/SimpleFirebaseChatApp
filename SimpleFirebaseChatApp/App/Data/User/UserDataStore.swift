//
//  UserDataStore.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation
import Firebase

protocol UserDataStoreProtocol {
    func createUser(doc: [String: Any],
                    imageData: Data,
                    completion: @escaping (Bool) -> Void)
    func getLoginUser(completion: @escaping (User) -> Void)
    func fetchAll(completion: @escaping ([User]) -> Void)
    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void)

}

class UserDataStore {

    var users: [User] = []

    init() {
    }

}

extension UserDataStore {

    func createUserToFirebase(email: String,
                              password: String,
                              username: String,
                              profileImageUrl: String,
                              completion: @escaping (Bool) -> Void) {
        let createUserToFirebase = Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                completion(false)
                return
            }

            guard let uid = res?.user.uid else { return }
            let docData = [
                "email": email,
                "username": username,
                "createdAt": Timestamp(),
                "profileImageUrl": profileImageUrl
            ] as [String : Any]

            Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
                if let err = err {
                    print("Firestoreへの保存に失敗しました。\(err)")
                    completion(false)
                    return
                }

                print("Firestoreへの情報の保存が成功しました。")
                completion(true)
            }
        }
    }

}

extension UserDataStore: UserDataStoreProtocol {

    func createUser(doc: [String: Any],
                    imageData: Data,
                    completion: @escaping (Bool) -> Void) {
        let email = doc["email"] as! String
        let password = doc["password"] as! String
        let username = doc["username"] as! String
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)


        storageRef.putData(imageData, metadata: nil) { (matadata, err) in
            if let err = err {
                print("Firestorageへの情報の保存に失敗しました。\(err)")
                completion(false)
            }

            storageRef.downloadURL { (url, err) in
                if let err = err {
                    print("Firestorageからのダウンロードに失敗しました。\(err)")
                    completion(false)
                }

                guard let urlString = url?.absoluteString else { return }
                self.createUserToFirebase(email: email,
                                          password: password,
                                          username: username,
                                          profileImageUrl: urlString) {
                    err in
                    completion(true)
                }
            }

        }
    }

    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void) {

        Auth.auth().signIn(withEmail: email, password: passWord) { (res, err) in
            if let err = err {
                print("ログインに失敗しました \(err)")
                completion(false)
                return
            }
            completion(true)
        }

    }

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
