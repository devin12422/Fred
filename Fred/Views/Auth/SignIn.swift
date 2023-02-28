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
    var body: some View {
        VStack{
            TextField("Email", text: $email).padding()
            SecureField("Password",text: $password).padding()
            Button{}label:{Text("Forgot Password")}
            Button{
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){data,error in
                    if(error == nil){
                        User.current = User(email: email)
                    }else{
                        alert(isPresented:Binding<Bool>(get:{error == nil},set:{_ in})){
    
                              Alert(
                                  title: Text("Error"),
                                  message: Text(error!.localizedDescription)
                              )
                          }
                        print(error?.localizedDescription)
                    }
                    
                }
            }label:{
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
