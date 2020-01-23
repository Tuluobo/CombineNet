//
//  ContentView.swift
//  Example
//
//  Created by Hao Wang on 2020/1/23.
//  Copyright © 2020 Tuluobo. All rights reserved.
//

import SwiftUI
import CombineNet
import Combine

struct ContentView: View {
    
    @State var cancellable: Cancellable?
    
    var body: some View {
        VStack {
            Text("Hello")
            Button(action: {
                let publisher: AnyPublisher<String, Error> = Client
                    .get("https://bytedance.net", JSONDecoder())
                    .map(\.value)
                    .eraseToAnyPublisher()
                self.cancellable = publisher.sink(receiveCompletion: { (result) in
                    switch result {
                    case .failure(let error):
                        print("error: \(error)")
                    case .finished:
                        print("Finish")
                    }
                }) { (data) in
                    print("data: \(data)")
                }
            }) {
                Text("World")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
