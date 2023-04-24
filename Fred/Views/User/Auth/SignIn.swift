//
//  SignIn.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth

struct SignIn: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var loading = false
    @State var is_error = false
    @State var error_msg = ""
    @EnvironmentObject var user:User
    var body: some View {
        VStack{
            TextField("Email", text: $user.email).autocapitalization(.none).padding()
            SecureField("Password",text: $password).padding()
//        if let message = errorMessage {
//    Text(message).foregroundColor(.red).padding()
//            }
//            Button{}label:{Text("Forgot Password")}
            Button{
                    loading = true
                    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){data,error in
                        user.uid = data?.user.uid

                    if(error == nil){
                        user.get()
                    }else{
                        error_msg = error!.localizedDescription

                        is_error = true

                    }
                        loading = false

                    
                    }
                    
            }label:{
                Text("Sign In")
            }.disabled(loading || (password.count < 6))
        }.alert(isPresented: $is_error) {Alert(title: Text("Error"), message: Text(error_msg),dismissButton: .default(Text("Ok")){})}
        }
    }

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}

