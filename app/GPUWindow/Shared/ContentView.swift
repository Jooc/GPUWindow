//
//  ContentView.swift
//  Shared
//
//  Created by 齐旭晨 on 2022/3/21.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var store: Store
    @State var appState = AppState()
    @ObservedObject var client: Client = Client(host: "127.0.0.1", port: 31500)
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button("Tap to Connect"){
                //                self.store.connect()
                self.client.start()
                self.client.send(data: "Hello Server".data(using: .utf8)!)
            }
            //            Text(self.store.client.connection.words)
            //                    .padding()
            Text(self.client.words)
                .padding()
        }.frame(width: 500, height: 700, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
