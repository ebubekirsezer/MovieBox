//
//  UIViewController+Network.swift
//  MovieBox
//
//  Created by EbubekirSezer on 29.08.2022.
//

import Foundation
import Network

extension BaseViewController {
    
    func monitorNetwork() {
        if #available(iOS 12.0, *) {
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    Constants.isConnectedToNetwork = true
                }
                else if path.status == .unsatisfied {
                    DispatchQueue.main.async {
                        Constants.isConnectedToNetwork = false
                        self.showNetworkError()
                    }
                }
            }
            
            let queue = DispatchQueue(label: "Network")
            monitor.start(queue: queue)
        }
    }
}
