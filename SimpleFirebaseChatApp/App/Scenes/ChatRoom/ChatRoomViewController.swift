//
//  ChatRoomViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//

import UIKit

class ChatRoomViewController: UIViewController {

    private lazy var chatRoomInputView: ChatRoomInputView = {
        let view = ChatRoomInputView()
        view.view = self as! ChatInputViewDelegate
        view.backgroundColor = .white
        return view
    }()

    private var chatRoomTableView = UITableView()

    private let chatRoomInputViewHeight: CGFloat = 100
    private var navberHeight: CGFloat {
        ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height)
    }

    private var presenter: ChatRoomPresenterProtocol!
    

    func inject(presenter: ChatRoomPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .chatRoomBackColor

        self.navigationController?.navigationBar.barTintColor = .navBarColor
        self.navigationItem.title = "トーク一覧"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        self.view.addSubview(self.chatRoomTableView)
        self.view.addSubview(self.chatRoomInputView)

        setupChatRoomInputView()
        setupChatTableView()
    }

    private func setupChatRoomInputView() {
        self.chatRoomInputView.translatesAutoresizingMaskIntoConstraints = false
        self.chatRoomInputView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.chatRoomInputView.widthAnchor.constraint(equalToConstant: widthValue).isActive = true
        self.chatRoomInputView.heightAnchor.constraint(equalToConstant: self.chatRoomInputViewHeight).isActive = true
        self.chatRoomInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }


    private func setupChatTableView() {
        self.chatRoomTableView.delegate = self
        self.chatRoomTableView.dataSource = self

        self.chatRoomTableView.rowHeight = UITableView.automaticDimension

        self.chatRoomTableView.backgroundColor = .chatRoomBackColor
        self.chatRoomTableView.allowsSelection = false
        self.chatRoomTableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        self.chatRoomTableView.register(UINib(nibName: ChatRoomPartnerUserCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ChatRoomPartnerUserCell.cellIdentifier)
        self.chatRoomTableView.register(UINib(nibName: ChatRoomCurrentUserCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ChatRoomCurrentUserCell.cellIdentifier)
        self.chatRoomTableView.separatorStyle = .none

        self.chatRoomTableView.translatesAutoresizingMaskIntoConstraints = false
        self.chatRoomTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.chatRoomTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navberHeight).isActive = true
        self.chatRoomTableView.bottomAnchor.constraint(equalTo: self.chatRoomInputView.topAnchor, constant: 0).isActive = true
        self.chatRoomTableView.widthAnchor.constraint(equalToConstant: widthValue).isActive = true
    }


}


extension ChatRoomViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 60
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfUsers
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUserCell = chatRoomTableView.dequeueReusableCell(withIdentifier: ChatRoomCurrentUserCell.cellIdentifier) as! ChatRoomCurrentUserCell

        let partnerUserCell = chatRoomTableView.dequeueReusableCell(withIdentifier: ChatRoomPartnerUserCell.cellIdentifier) as! ChatRoomPartnerUserCell

        guard let partnerUser = self.presenter.partnerUser,
              let currentUser = self.presenter.currentUser,
              let message = self.presenter.checkMessageRow(forRow: indexPath.row)
        else {
            return currentUserCell
        }


        if message.userId == currentUser.uid {
            currentUserCell.setupValue(message: message.message)
            return currentUserCell
        } else {
            partnerUserCell.setupValue(message: message.message,
                                       user: partnerUser)
            return partnerUserCell
        }
    }


}

extension ChatRoomViewController: ChatInputViewDelegate {
    func tappedSendButton(text: String) {
        self.chatRoomInputView.removeText()
        self.presenter.tappedSendButton(text: text)
    }
}

extension ChatRoomViewController: ChatViewProtocol {
    func reloadTableView() {
        self.chatRoomTableView.reloadData()
    }
}
