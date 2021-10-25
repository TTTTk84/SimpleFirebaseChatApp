//
//  MessageDataStore.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Firebase

protocol MessageDataStoreProtocol {
    func fetchMessageAll(chatRoomDocumentId: String,
                         completion: @escaping ([Message]) -> Void)
    func createMessage(message: Message,
                       chatRoomDocumentId: String,
                       completion: @escaping([Message]) -> Void)
}

class MessageDataStore {
    var messages: [Message] = []

    init() {}
}

extension MessageDataStore: MessageDataStoreProtocol {
    func fetchMessageAll(chatRoomDocumentId: String,
                         completion: @escaping ([Message]) -> Void) {
        Firestore.firestore().collection("chatRooms").document(chatRoomDocumentId).collection("messages").getDocuments {
            (snapshots, err) in
            self.messages = []
            if err != nil {
                return
            }
            snapshots?.documents.forEach({ (snapshot) in
                let dic = snapshot.data()
                let message = Message(dic: dic)
                self.messages.append(message)
            })
            completion(self.messages)
        }
    }

    func createMessage(message: Message,
                       chatRoomDocumentId: String,
                       completion: @escaping ([Message]) -> Void) {

        let dic: [String: Any] = [
            "name": message.name,
            "createdAt": Timestamp(),
            "userId": message.userId,
            "message": message.message
        ] as [String : Any]

        Firestore.firestore().collection("chatRooms").document(chatRoomDocumentId).collection("messages").addDocument(data: dic) {
            (err) in
            if let err = err {
                return
            }

            Firestore.firestore().collection("chatRooms").document(chatRoomDocumentId).collection("messages").getDocuments {
                (snapshots, err) in
                self.messages = []
                if err != nil {
                    return
                }
                snapshots?.documents.forEach({ (snapshot) in
                    let dic = snapshot.data()
                    let message = Message(dic: dic)
                    self.messages.append(message)
                })
                completion(self.messages)
            }
        }
    }

    
}
