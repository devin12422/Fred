//
//  SignUp.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth

struct SignUp: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var loading = false
    var body: some View {
        VStack{
            TextField("Email", text: $email).padding()
            SecureField("Password",text: $password).padding()
            Button{
                if(!loading){
                    loading = true
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password){data,error in
                    if(error == nil){
                        loading = false
                        print("signed up")
                    }else{
                        loading = true

                        print(error?.localizedDescription)
                    }
                }
                    
                }
            }label:{
                Text("Sign Up")
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
