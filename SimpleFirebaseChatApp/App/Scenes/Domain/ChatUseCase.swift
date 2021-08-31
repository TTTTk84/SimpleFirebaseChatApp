//
//  ChatUseCase.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol ChatUseCaseProtocol {
    func createUser()
    func loginUser()

    var userGateway: UserGatewayProtocol! { get set }
}



class ChatUseCase {

    var userGateway: UserGatewayProtocol!


    init() {}
}

extension ChatUseCase: ChatUseCaseProtocol {

    func createUser() {
    }

    func loginUser() {
    }

    
}
