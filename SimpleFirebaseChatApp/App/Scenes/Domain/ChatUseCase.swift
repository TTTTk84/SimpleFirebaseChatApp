//
//  ChatUseCase.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol ChatUseCaseProtocol {
    func createUser()
    func getLoginUser(completion: @escaping (User) -> Void)
    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void)
    func fetchUserAll()

    func fetchChatRoomAll()
    func createChatRoom(chatRoomName: String, members: [User])

    var userGateway: UserGatewayProtocol! { get set }
    var chatRoomGateway: ChatRoomGatewayProtocol! { get set }

    var chatListOutput: ChatUseCaseChatListOutput! { get set }
    var userListOutput: ChatUseCaseUserListOutput! { get set }
}

protocol ChatUseCaseChatListOutput {
    func useCaseDidUpdate(chatroom: [ChatRoom])
    func useCaseTitleUpdate(title: String)
}

protocol ChatUseCaseUserListOutput {
    func useCaseDidUpdate(userList: [User])
}

class ChatUseCase {

    var userGateway: UserGatewayProtocol!
    var chatRoomGateway: ChatRoomGatewayProtocol!


    var chatListOutput: ChatUseCaseChatListOutput!
    var userListOutput: ChatUseCaseUserListOutput!

    private(set) var userList: [User] = []
    private(set) var chatRoom: [ChatRoom] = []

    init() {}
}

extension ChatUseCase: ChatUseCaseProtocol {
    func checkLoginUser(email: String, passWord: String, completion: @escaping (Bool) -> Void) {
        self.userGateway.checkLoginUser(email: email,
                                        passWord: passWord) {[weak self] bool in
            completion(bool)
        }
    }


    func fetchUserAll() {
        self.userGateway.fetchAll() { [weak self] userList in
            self?.userList = userList
            self?.userListOutput.useCaseDidUpdate(userList: self!.userList)
        }
    }


    func createUser() {
    }

    func getLoginUser(completion: @escaping (User) -> Void) {
        self.userGateway.getLoginUser() { [weak self] user in
            completion(user)
        }
    }


    func fetchChatRoomAll() {
        self.chatRoomGateway.fetchAll() { [weak self] chatRoom in
            self?.chatRoom = chatRoom
            self?.chatListOutput.useCaseDidUpdate(chatroom: self!.chatRoom)
        }
    }

    func createChatRoom(chatRoomName: String, members: [User]) {

        let dic: [String: Any] = [
            "chatRoomName": chatRoomName,
            "latestMessageId": "newMessage",
            "members": members,
        ]

        let newChatRoom = ChatRoom(dic: dic)

        self.chatRoomGateway.createChatRoom(chatRoom: newChatRoom) {
            [weak self] chatRoom in

            self?.chatRoom = chatRoom
            self?.chatListOutput.useCaseDidUpdate(chatroom: self!.chatRoom)
        }
    }
}
