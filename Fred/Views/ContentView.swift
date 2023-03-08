//
//  ContentView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    var body: some View {
        if(Auth.auth().currentUser == nil){
            NavigationView{
                VStack{
                NavigationLink{
                    SignUp()
                }label:{
                    Text("Sign Up")
                }
                NavigationLink{
                    SignIn()
                }label:{
                    Text("Sign In")
                }

                }
            }
        }else{
            TabView{
                PostCreateView().tabItem{
                    Label("Post", systemImage: "doc")
                }
                PostListView().tabItem{
                    Label("Feed", systemImage: "doc.text")
                }
                SettingsView().tabItem{
                    Label("Settings",systemImage: "settings")
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
