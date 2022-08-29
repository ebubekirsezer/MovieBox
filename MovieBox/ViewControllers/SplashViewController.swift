//
//  SplashViewController.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseRemoteConfig

final class SplashViewController: BaseViewController {
    
    @IBOutlet private weak var labelTitle: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        redirectToSearchView()
        labelTitle?.text = UserDefaults.standard.string(forKey: "app_name")
    }
    
    func redirectToSearchView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setRootNavigationController(with: "MoviesNavigationViewController", from: "Main")
        }
    }
}
