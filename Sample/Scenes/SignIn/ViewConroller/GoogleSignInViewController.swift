//
//  GoogleSignInViewController.swift
//  YouTubeLiveVideo
//
//  Created by Sergey Krotkih
//

import UIKit
import GoogleSignIn

// [START viewcontroller_interfaces]
class GoogleSignInViewController: BaseViewController {
    // [END viewcontroller_interfaces]

    var viewModel: SignInProtocol!

    // [START viewcontroller_vars]
    @IBOutlet weak var signInButton: GIDSignInButton!
    // [END viewcontroller_vars]

    // [START viewdidload]
    override func viewDidLoad() {
        super.viewDidLoad()
        startListeningToSignIn()
        viewModel.configureSignIn(for: self)
    }
    // [END viewdidload]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Private Methods

extension GoogleSignInViewController {

    private func startListeningToSignIn() {
        viewModel
            .startListeningToSignIn { result in
            switch result {
            case .success:
                Router.showMainViewController()
            case .failure(let error):
                switch error {
                case .systemMessage(let code, let message):
                        if code == 401 {
                            print(message)
                        } else {
                            Alert.sharedInstance.showOk("", message: message)
                        }
                case .message(let message):
                        Alert.sharedInstance.showOk("", message: message)
                }
            }
        }
    }
}
