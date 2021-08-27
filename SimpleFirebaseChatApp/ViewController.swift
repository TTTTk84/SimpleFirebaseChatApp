//
//  ViewController.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/14.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.createUserImage()
    }

    private func createUserImage() {
        let image = UIImage(named: "boy")
        guard let uploadImage = image?.jpegData(compressionQuality: 0.3) else { return }

        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)

        storageRef.putData(uploadImage, metadata: nil) { (matadata, err) in
            if let err = err {
                print("Firestorageへの情報の保存に失敗しました。\(err)")
                return
            }

            storageRef.downloadURL { (url, err) in
                if let err = err {
                    print("Firestorageからのダウンロードに失敗しました。\(err)")
                    return
                }

                guard let urlString = url?.absoluteString else { return }
                self.createUserToFirestore(profileImageUrl: urlString)
            }

        }

    }

    private func createUserToFirestore(profileImageUrl: String) {
        let email = "user1@a.com"
        let pass = "aaaaaa"

        Auth.auth().createUser(withEmail: email, password: pass) {(res, err) in
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                return
            }

            guard let uid = res?.user.uid else { return }
            let username = "user1"
            let docData = [
                "email": email,
                "username": username,
                "createdAt": Timestamp(),
                "profileImageUrl": profileImageUrl
            ] as [String : Any]

            Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
                if let err = err {
                    print("Firestoreへの保存に失敗しました。\(err)")
                    return
                }

                print("Firestoreへの情報の保存が成功しました。")
                self.dismiss(animated: true, completion: nil)

            }
        }
    }

}
