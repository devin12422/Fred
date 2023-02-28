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
        if(User.current == nil){
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
                PostView().tabItem{
                    Label("Post", systemImage: "doc.text")
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
