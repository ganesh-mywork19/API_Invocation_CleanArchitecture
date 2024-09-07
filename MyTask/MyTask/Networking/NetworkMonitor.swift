//
//  NetworkMonitor.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation
import Network

enum NetworkStatus {
   case connected
   case disconnected
}

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private var networkMonitor: NWPathMonitor!
    var status:NetworkStatus = .disconnected
    
    private init(){
        start()
    }
    
    private func start(){
        networkMonitor = NWPathMonitor()
        networkMonitor.start(queue: DispatchQueue(label: "NetworkConnectivityMonitor"))
        networkMonitor.pathUpdateHandler = {[weak self] path in
            guard let self else { return }
            let isConnected = path.status != .unsatisfied
            status = isConnected ? .connected : .disconnected
        }
    }
    
//    deinit {
//        networkMonitor.cancel()
//        networkMonitor = nil
//    }
}
