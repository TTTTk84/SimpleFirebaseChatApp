//
//  ChatRoomDataStore.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation
import Firebase

protocol ChatRoomDataStoreProtocol {
    func fetchAll(completion: @escaping ([ChatRoom]) -> Void)
    func createChatRoom(chatRoom: ChatRoom, completion: @escaping ([ChatRoom]) -> Void)
}


class ChatRoomDataStore {

    var chatRooms: [ChatRoom] = []
    init(){}

}

extension ChatRoomDataStore {
    private func getUser(documentId: String,
                         completion: @escaping (User) -> Void) {

        Firestore.firestore().collection("users").document(documentId).getDocument { (snapshot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗しました。\(err)")
                return
            }

            guard let snapshot = snapshot,
                  let dic = snapshot.data() else { return }

            let user = User(dic: dic)
            completion(user)
        }


    }
}

extension ChatRoomDataStore: ChatRoomDataStoreProtocol {


    func fetchAll(completion: @escaping ([ChatRoom]) -> Void) {
        Firestore.firestore().collection("chatRooms").getDocuments {
            (snapshots, err) in

            if let err = err {
                print("chatRoomの情報の取得に失敗しました \(err)")
                return
            }
            snapshots?.documents.forEach { (snapshot) in
                let dic = snapshot.data()
                let chatRoom = ChatRoom(dic: dic)
                chatRoom.documentId = snapshot.documentID
                for user in chatRoom.members {
                    guard let uid = Auth.auth().currentUser?.uid
                    else { return }
                    if uid == user {
                        let partnerUser = chatRoom.members.filter { $0 != uid }
                        print("partnerUser: \(partnerUser)")
                        self.getUser(documentId: partnerUser[0]) {
                            user in
                            print("user: \(user.username)")
                            chatRoom.partnerUser = user
                            self.chatRooms.append(chatRoom)
                        }
                        break
                    }
                }
            }
            print("chatroomarray: \(self.chatRooms)")
            completion(self.chatRooms)
        }
    }

    func createChatRoom(chatRoom: ChatRoom, completion: @escaping ([ChatRoom]) -> Void) {

        let dic: [String: Any] = [
            "latestMessageId": "",
            "members": chatRoom.members,
            "chatRoomName": chatRoom.chatRoomName,
            "createdAt": Timestamp()
        ]

        Firestore.firestore().collection("chatRooms").addDocument(data: dic) { (err) in
            if let err = err {
                print("ChatRoom情報の保存に失敗しました。\(err)")
                return
            }

            print("ChatRoom情報の保存に成功しました。")
        }
    }
}
