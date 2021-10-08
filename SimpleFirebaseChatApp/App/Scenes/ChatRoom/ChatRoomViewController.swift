//
//  ChatRoomViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//

import UIKit

class ChatRoomViewController: UIViewController {

    private let chatRoomInputView: ChatRoomInputView = {
        let view = ChatRoomInputView()
        view.backgroundColor = .white
        //view.frame = CGRect(x: 0, y: 0, width: widthValue, height: 100)
        return view
    }()

    private var chatRoomTableView = UITableView()


    private let chatRoomInputViewHeight: CGFloat = 100
    private var navberHeight: CGFloat {
        ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height)
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
//        self.chatRoomTableView.heightAnchor.constraint(equalToConstant: heightValue).isActive = true
    }

//    override var inputAccessoryView: UIView? {
//        self.chatRoomInputView
//    }
//
//    override var canBecomeFirstResponder: Bool { true }
}


extension ChatRoomViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 60
        return UITableView.automaticDimension
        //return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = chatRoomTableView.dequeueReusableCell(withIdentifier: ChatRoomCurrentUserCell.cellIdentifier) as! ChatRoomCurrentUserCell
        cell1.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)

        let cell2 = chatRoomTableView.dequeueReusableCell(withIdentifier: ChatRoomPartnerUserCell.cellIdentifier) as! ChatRoomPartnerUserCell
        cell2.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)

        if indexPath.row < 5 {
            cell1.messageTextView.text = "hoge\(indexPath.row)"
            return cell1
        } else {
            cell2.messageTextView.text = "fuga\(indexPath.row)ijoiwjefrajeoifraowefoaw3rjo;wei4ftoawefoself.messageTextView.layer.cornerRadius = 15            self.messageTextView.isEditable = false            self.messageTextView.isSelecta"
            return cell2
        }
    }


}
