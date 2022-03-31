//
//  Store.swift
//  GPUWindow
//
//  Created by 齐旭晨 on 2022/3/28.
//

import Foundation
import Combine

//class Store: ObservableObject{
//    @Published var appState = AppState()
////    var client: Client = Client(host: "127.0.0.1", port: 31500)
//    
//    func connect(){
////        self.client.start()
////        self.client.connection.send(data: "Hello Server".data(using: .utf8)!)
//    }
//}
//
//extension Store{
//    struct TCPClient{
//        var words: String = ""
//
//        var host: String
//        var port: UInt16
//
//        var client: Client
//
//        mutating func initClient(){
//            self.client = Client(host: self.host, port: self.port)
//            self.client.start()
//
//            client.connection.send(data: ("Hello Server".data(using: .utf8))!)
//        }
//    }
//}
