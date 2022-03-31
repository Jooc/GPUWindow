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
    @ObservedObject var client: Client = Client(host: "192.168.31.238", port: 31500)
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button("Tap to Connect"){
                //                self.store.connect()
                self.client.start()
                self.client.send(data: "App Client".data(using: .utf8)!)
            }
            //            Text(self.store.client.connection.words)
            //                    .padding()
            Text(self.client.words)
                .padding()
            
            Text("Total Memory: " + self.client.memoryTotal)
            Text("Used Memory: " + self.client.memoryUsed)
            Text("Memory Utilization: " + self.client.memoryUtilization)
            Text("GPU Utilization: " + self.client.gpuUtilization)
            
        }.frame(width: 500, height: 700, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
