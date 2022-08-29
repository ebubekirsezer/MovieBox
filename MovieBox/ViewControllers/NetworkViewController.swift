//
//  NetworkViewController.swift
//  MovieBox
//
//  Created by EbubekirSezer on 29.08.2022.
//

import UIKit

final class NetworkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func buttonTryAgainTapped(_ sender: UIButton) {
        if Constants.isConnectedToNetwork {
            self.dismiss(animated: true)
        }
    }
}
