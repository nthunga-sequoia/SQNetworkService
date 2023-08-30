//
//  ContentView.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Veriy Username") {
                let authenticationManager = AuthenticationManager()
                authenticationManager.veriyUserName(emailId: "s1demo@sequoia.com")
                authenticationManager.getUserProfile()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
