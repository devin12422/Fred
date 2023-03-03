//
//  ContentView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct ContentView: View {

    var body: some View {
        
        NavigationView {
            List {
                ForEach(1...10, id: \.self) { post in
                    NavigationLink(destination: Text("Post \(post)")) {
                    VStack(alignment: .leading) {
                            Text("Post \(post) Title").font(.headline)
                        Text("Description of Post\(post)").font(.subheadline).foregroundColor(.gray)
                                      }
                                  }
                }
            }.navigationTitle("Social Media Feed")

        }
    
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
