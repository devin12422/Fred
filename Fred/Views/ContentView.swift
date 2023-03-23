//
//  ContentView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @State var uid:String? = Auth.auth().currentUser?.uid
    var body: some View {
        if (uid == nil){
            NavigationView{
                VStack{
                NavigationLink{
                    SignUp(uid:$uid)
                }label:{
                    Text("Sign Up")
                }
                NavigationLink{
                    SignIn(uid:$uid)
                }label:{
                    Text("Sign In")
                }

                }
            }
        }else{
            
            TabView{
                PostCreateView(post:Post(uid: uid!)).tabItem{
                    Label("Post", systemImage: "doc")
                }
                PostListView().tabItem{
                    Label("Feed", systemImage: "tray.full")
                }
                SettingsView(uid:$uid).tabItem{
                    Label("Settings",systemImage: "person.crop.circle")
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
