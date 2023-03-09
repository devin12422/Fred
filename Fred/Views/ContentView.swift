//
//  ContentView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @State var logged = Auth.auth().currentUser != nil
    var body: some View {
        if(!logged){
            NavigationView{
                VStack{
                NavigationLink{
                    SignUp(logged: $logged)
                }label:{
                    Text("Sign Up")
                }
                NavigationLink{
                    SignIn(logged: $logged)
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
                SettingsView(logged: $logged).tabItem{
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
