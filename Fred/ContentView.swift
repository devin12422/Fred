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
                        HStack {
                            Image("profile-picture").resizable().scaledToFit().frame(width: 40, height: 40).clipShape(Circle())
                            Text("username").font(.subheadline) .fontWeight(.bold)
                            
                        }.padding(.bottom, 8)
                           
                    Text("Post \(post) Title").font(.title3).fontWeight(.bold)
                        Text("Description of Post \(post)").font(.subheadline).foregroundColor(.gray).padding(.bottom, 8)
                        HStack {
                            Image(systemName: "heart")
                            Text("Like")
                            Image(systemName: "message")
                            Text("Comment")
                        }.padding(.top, 8).foregroundColor(.gray)
                    
                    }.padding().background(Color.white).cornerRadius(10)
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
