//
//  SignUp.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
struct SignUp: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var loading = false
    @State var is_error = false
    @State var error_msg = ""
    @EnvironmentObject var user:User
    var body: some View {
        VStack{
            TextField("Email", text: $email).autocapitalization(.none).padding()
            SecureField("Password",text: $password).padding()
            Button{
                if(!loading){
                    loading = true
                    print("bruh?")
                    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password){data,error in
                        if(error == nil){
                            
                            let encoder = JSONEncoder();
                            let encoded = try? encoder.encode(User(email: email, username: email,uid:data!.user.uid));
                            Storage.storage().reference().child("users/\(data!.user.uid)/user").putData(encoded!){
                                mdata,merror in
                                user.uid = data?.user.uid

                                if(merror == nil){
                                    user.get()
                                }else{
                                    error_msg = merror!.localizedDescription
                                    is_error = true

                                }
                                loading = false

                            }
                        }else{
                            print("unbruh?")
                            
                            error_msg = error!.localizedDescription
                                is_error = true
                            
                            
                        }
                    }
                }
            }label:{
                Text("Sign Up")
            }.disabled(loading)
        }.alert(isPresented: $is_error) {Alert(title: Text("Error"), message: Text(error_msg),dismissButton: .default(Text("Ok")){})}
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
