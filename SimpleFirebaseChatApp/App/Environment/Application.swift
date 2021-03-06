//
//  Application.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//


import UIKit


class Application {

    static let shared = Application()
    private init() {}

    private(set) var userUseCase: UserUsecaseProtocol!
    private(set) var chatRoomUseCase: ChatRoomUsecaseProtocol!
    private(set) var messageUseCase: MessageUsecaseProtocol!

    func configure(with window: UIWindow) {
        buildLayer()

        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)

        let loginRouter = LoginRouter(view: loginViewController)
        let loginPresenter = LoginPresenter(router: loginRouter,
                                            useCase: self.userUseCase)
        loginViewController.inject(presenter: loginPresenter)

        //let vc = ViewController()

        window.rootViewController = navigationController
    }


    // MARK: Private Methods

    private func buildLayer() {

        self.userUseCase = UserUseCase()
        self.chatRoomUseCase = ChatRoomUsecase()
        self.messageUseCase = MessageUsecase()

        let userGateway = UserGateway(userUseCase: self.userUseCase)
        self.userUseCase.userGateway = userGateway
        let userDataStore = UserDataStore()
        userGateway.dataStore = userDataStore

        let chatRoomGateway = ChatRoomGateway(chatRoomUseCase: self.chatRoomUseCase)
        self.chatRoomUseCase.chatRoomGateway = chatRoomGateway
        let chatRoomDataStore = ChatRoomDataStore()
        chatRoomGateway.dataStore = chatRoomDataStore

        let messageGateway = MessageGateway(messageUseCase: self.messageUseCase)
        self.messageUseCase.messageGateway = messageGateway
        let messageDataStore = MessageDataStore()
        messageGateway.dataStore = messageDataStore



    }

}
