//
//  Client.swift
//  GPUWindow
//
//  Created by 齐旭晨 on 2022/3/28.
//

import Foundation
import Network
import Combine
import SwiftUI

class Client: ObservableObject{
    @Published var words: String = "123123123"
    
    let host: NWEndpoint.Host
    let port: NWEndpoint.Port
    let queue = DispatchQueue(label: "Client connection Q")
    
    var nwConnection: NWConnection
    
    init(host: String, port: UInt16) {
        self.host = NWEndpoint.Host(host)
        self.port = NWEndpoint.Port(rawValue: port)!
        self.nwConnection = NWConnection(host: self.host, port: self.port, using: .tcp)
    }
    
    func start(){
        print("Client started \(host) \(port)")
        
        nwConnection.stateUpdateHandler = stateDidChange(to: )
        setupReceive()
        nwConnection.start(queue: queue)
    }
    
    func send(data: Data){
        nwConnection.send(content: data, completion: .contentProcessed({error in
            if let error = error{
                self.connectionDidFail(error: error)
                return
            }
            print("connection did send, data: \(data as NSData)")
        }))
    }
    
    func stop(){
        print("connection will stop")
        stop(error: nil)
    }
    
//    func didStopCallback(error: Error?){
//        if error == nil{
//            exit(EXIT_SUCCESS)
//        }else{
//            exit(EXIT_FAILURE)
//        }
//    }
    
    private func setupReceive(){
        nwConnection.receive(minimumIncompleteLength: 1, maximumLength: 65536){(data, _, isComplete, error) in
            if let data = data, !data.isEmpty{
                let message = String(data: data, encoding: .utf8)
                self.words = message ?? ""
                print("connection did receive, data: \(data as NSData) string: \(message ?? "-")")
                print(self.words)
            }
            if isComplete{
                self.connectionDidEnd()
            }else if let error = error {
                self.connectionDidFail(error: error)
            }else{
                self.setupReceive()
            }
        }
    }
    
    private func stateDidChange(to state: NWConnection.State){
        switch state{
        case .waiting(let error):
            connectionDidFail(error: error)
        case .ready:
            print("Client connection ready")
        case .failed(let error):
            connectionDidFail(error: error)
        default:
            break
        }
    }
    
    private func connectionDidFail(error: Error){
        print("connection did fail, error: \(error)")
        self.stop(error: error)
    }
    
    private func connectionDidEnd() {
        print("connection did end")
        self.stop(error: nil)
    }
    
    private func stop(error: Error?){
        self.nwConnection.stateUpdateHandler = nil
        self.nwConnection.cancel()
//        if let didStopCallback = self.didStopCallback {
//            self.didStopCallback = nil
//            didStopCallback(error)
//        }
    }
}


//struct ClientConnection{
//    let nwConnection: NWConnection
//    let queue = DispatchQueue(label: "Client connection Q")
//
//    init(nwConnection: NWConnection, words: inout String) {
//        self.nwConnection = nwConnection
//        self.words = words
//    }
//
//    var didStopCallback: ((Error?)->Void)? = nil
//
//    func start() {
//        print("connection will start")
//        nwConnection.stateUpdateHandler = stateDidChange(to: )
//        setupReceive()
//        nwConnection.start(queue: queue)
//    }
//}
