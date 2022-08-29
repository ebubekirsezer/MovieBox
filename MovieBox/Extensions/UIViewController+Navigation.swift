//
//  UIViewController+Navigation.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import UIKit

extension UIViewController {
    
    func getViewController<T: UIViewController>(viewController: T, from storyboard: String) -> T? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        if #available(iOS 13.0, *) {
            guard let nextViewController = storyboard.instantiateViewController(identifier: String(describing: T.self)) as? T else { return T() }
            return nextViewController
        } else {
            // Fallback on earlier versions
            guard let nextViewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else { return T() }
            return nextViewController
        }
    }
    
    func setRootNavigationController(with viewController: String, from storyboardName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if #available(iOS 13.0, *) {
            guard let rootViewController = storyboard.instantiateViewController(identifier: viewController) as? UINavigationController else { return }
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            // Fallback on earlier versions
            guard let rootViewController = storyboard.instantiateViewController(withIdentifier: viewController) as? UINavigationController else { return }
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    func showNetworkError() {
        if self.navigationController?.topViewController != NetworkViewController() {
            let storyboard = UIStoryboard(name: "Network", bundle: nil)
            if let networkViewController = getViewController(viewController: NetworkViewController(), from: "Network") {
                networkViewController.modalPresentationStyle = .fullScreen
                networkViewController.modalTransitionStyle = .crossDissolve
                self.present(networkViewController, animated: true, completion: nil)
            }
        }
    }
}
