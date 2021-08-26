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

    //private(set) var useCase: !

    func configure(with window: UIWindow) {
        buildLayer()

//        let todoIndexViewController = TodoIndexViewController()
//        let todoRouter = TodoIndexRouter(view: todoIndexViewController)
//        let todoIndexPresenter = TodoIndexPresenter(view: todoIndexViewController,
//                                                    useCase: self.useCase,
//                                                    router: todoRouter)
//        todoIndexViewController.inject(presenter: todoIndexPresenter)
//        let navigatonController = UINavigationController(rootViewController: todoIndexViewController)

        //let loginViewController = LoginViewController()
        let loginViewController = UserDetailViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)

        let tempVC = ViewController()

        window.rootViewController = tempVC
    }


    // MARK: Private Methods

    private func buildLayer() {
//        self.useCase = TodoUseCase()
//
//        let todoGateway = TodoGateway(useCase: self.useCase)
//
//        useCase.todoGateway = todoGateway
//
//        let todoDataStore = TodoDataStore()
//        todoGateway.dataStore = todoDataStore
    }

}
