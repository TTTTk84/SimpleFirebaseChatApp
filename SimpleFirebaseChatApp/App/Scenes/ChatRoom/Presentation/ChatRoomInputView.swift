//
//  ChatRoomInputView.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

class ChatRoomInputView: UIView {

    @IBOutlet weak var sendTextView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)


        print("hoge")

        let nib = UINib(nibName: "ChatRoomInputView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)

        self.sendBtn.imageView?.contentMode = .scaleToFill
        self.sendBtn.contentHorizontalAlignment = .fill
        self.sendBtn.contentVerticalAlignment = .fill
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
