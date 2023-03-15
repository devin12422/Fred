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
    @State var errorMessage: String? = nil

    var body: some View {
        VStack{
            TextField("Email", text: $email).padding()
            SecureField("Password",text: $password).padding()
            if let message = errorMessage {
    Text(message).foregroundColor(.red).padding()
            }
//            Button{}label:{Text("Forgot Password")}
            Button{
                if(!loading){
                    loading = true
                    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){ data, error in
            DispatchQueue.main.async {
                        loading = false
                    }
if let error = error {
    print(error.localizedDescription)
    errorMessage = error.localizedDescription
                } else {
                    print("signed in")
                        
                    }
                }
    }
        } label: {
            if loading {
                ProgressView()
                    } else {
                        Text("Sign In")
                        }
                }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
}
