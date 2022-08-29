//
//  BaseViewController.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation
import UIKit
import Network

class BaseViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusBar()
        hideKeyboarAction()
        monitorNetwork()
    }
    
    func setupStatusBar() {
        UIApplication.shared.statusBarView?.backgroundColor = RGB(92, 160, 211)
    }
    
    func hideKeyboarAction() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
