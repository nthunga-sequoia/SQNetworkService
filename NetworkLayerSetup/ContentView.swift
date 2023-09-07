//
//  ContentView.swift
//  NetworkLayerSetup
//
//  Created by Naveen Thunga on 29/08/23.
//

import SwiftUI
import Combine

var result = Text(verbatim: "")
let email = "indy.ssa@mailinator.com"

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Veriy Username") {
                let authenticationManager = AuthenticationManager()
                authenticationManager.veriyUserName(emailId: email) { errorObject in
                    
                } success: {
                    print("Verified")
                }

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
