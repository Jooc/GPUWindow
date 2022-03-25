//
//  ContentView.swift
//  Shared
//
//  Created by 齐旭晨 on 2022/3/21.
//

import SwiftUI

struct ContentView: View {
    let client = TCPClient(host: "localhost", port: 3010)

    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button("Tap to Click"){
                do {
                    try client.start()
                }catch let error{
                    print("Error")
                    client.stop()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
