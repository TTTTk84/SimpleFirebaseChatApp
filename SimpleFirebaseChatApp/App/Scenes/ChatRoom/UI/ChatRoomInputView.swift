//
//  ChatRoomInputView.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

protocol ChatInputViewDelegate {
    func tappedSendButton(text: String)
}

class ChatRoomInputView: UIView {

    @IBOutlet weak var sendTextView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    var view: ChatInputViewDelegate?



    override init(frame: CGRect) {
        super.init(frame: frame)

        let nib = UINib(nibName: "ChatRoomInputView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)

        self.sendBtn.imageView?.contentMode = .scaleToFill
        self.sendBtn.contentHorizontalAlignment = .fill
        self.sendBtn.contentVerticalAlignment = .fill
        self.sendBtn.addTarget(self, action: #selector(tappedSendBtn), for: .touchUpInside)
    }

    @objc func tappedSendBtn(_ sender: Any) {
        guard let text = sendTextView.text else { return }
        if let view = view {
            view.tappedSendButton(text: text)
        }
    }

    func removeText() {
        sendTextView.text = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
