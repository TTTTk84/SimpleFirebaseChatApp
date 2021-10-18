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

    //    var chatRooms: [ChatRoom] = [
    //        ChatRoom(dic: ["latestMessageId": "message1",
    //                       "chatRoomName": "chatroom 1"])
    //    ]

    init(){}

}

extension ChatRoomDataStore: ChatRoomDataStoreProtocol {


    func fetchAll(completion: @escaping ([ChatRoom]) -> Void) {
        Firestore.firestore().collection("chatRooms").getDocuments {
            (snapshots, err) in
            var chatRoomArray: [ChatRoom] = []
            if let err = err {
                print("chatRoomの情報の取得に失敗しました \(err)")
                return
            }
            snapshots?.documents.forEach { (snapshot) in
                let dic = snapshot.data()
                let chatRoom = ChatRoom(dic: dic)
                for user in chatRoom.memebers {
                    guard let uid = Auth.auth().currentUser?.uid
                    else { return }
                    if uid == user.documentId {
                        chatRoomArray.append(chatRoom)
                        break
                    }
                }
            }
            completion(chatRoomArray)
        }
    }

    func createChatRoom(chatRoom: ChatRoom, completion: @escaping ([ChatRoom]) -> Void) {

        var u = User(dic: ["hoge": "hoge"])
//        Firestore.firestore().collection("chatRooms").addDocument(data: docData) { (err) in
//            if let err = err {
//                print("ChatRoom情報の保存に失敗しました。\(err)")
//                return
//            }
//
//            print("ChatRoom情報の保存に成功しました。")
//
//        }
    }
}
