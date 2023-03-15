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
    @Binding var logged:Bool
    var body: some View {
        VStack{
            TextField("Email", text: $email).padding()
            SecureField("Password",text: $password).padding()
//            Button{}label:{Text("Forgot Password")}
            Button{
                if(!loading){
                    loading = true
                    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){data,error in
                    if(error == nil){
                        loading = false
                        logged = true

                    }else{
                        loading = false
                        print(error?.localizedDescription)
                    }
                    
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
        SignIn(logged:Binding.constant(false))
    }
}
