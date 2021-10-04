//
//  ChatRoomUseCase.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/10/03.
//

import Foundation


protocol ChatRoomUsecaseProtocol {
    func fetchChatRoomAll()
    func createChatRoom(chatRoomName: String, members: [User])

    var chatRoomGateway: ChatRoomGatewayProtocol! { get set }
    var chatListOutput: ChatUseCaseChatListOutput! { get set }
}

protocol ChatUseCaseChatListOutput {
    func useCaseDidUpdate(chatroom: [ChatRoom])
    func useCaseTitleUpdate(title: String)
}

class ChatRoomUsecase {

    var chatRoomGateway: ChatRoomGatewayProtocol!
    var chatListOutput: ChatUseCaseChatListOutput!
    private(set) var chatRoom: [ChatRoom] = []
    
    init() {}
}

extension ChatRoomUsecase: ChatRoomUsecaseProtocol {

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
