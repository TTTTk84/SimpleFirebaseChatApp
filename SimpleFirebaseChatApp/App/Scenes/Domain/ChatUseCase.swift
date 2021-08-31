//
//  ChatUseCase.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol ChatUseCaseProtocol {
    func createUser()
    func getLoginUser()
    func fetchUserAll()
    func fetchChatRoomAll()

    var userGateway: UserGatewayProtocol! { get set }
    var chatRoomGateway: ChatRoomGatewayProtocol! { get set }

    var chatListOutput: ChatUseCaseChatListOutput! { get set }
    var userListOutput: ChatUseCaseUserListOutput! { get set }
}

protocol ChatUseCaseChatListOutput {
    func useCaseDidUpdate(chatroom: [ChatRoom])
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


    func fetchChatRoomAll() {
        self.chatRoomGateway.fetchAll() { [weak self] chatRoom in
            self?.chatRoom = chatRoom
            self?.chatListOutput.useCaseDidUpdate(chatroom: self!.chatRoom)
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

    func getLoginUser() {
    }

    
}
