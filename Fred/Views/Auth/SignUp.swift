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
    @Binding var uid:String?
    var body: some View {
        VStack{
            TextField("Email", text: $email).autocapitalization(.none).padding()
            SecureField("Password",text: $password).padding()
            Button{
                if(!loading){
                    loading = true
                    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password){data,error in
                        if(error == nil){
                            uid = data?.user.uid
    
                            let encoder = JSONEncoder();
                            let encoded = try? encoder.encode(User(email: email, username: email,uid:uid!));
                            Storage.storage().reference().child("users/\(uid!)").putData(encoded!){
                                mdata,merror in
                                    if(merror == nil){
                                        loading = false
                                    }else{
                                        print(merror!.localizedDescription)
                                    }
                                }
                            }else{
                                print(error!.localizedDescription)
                                loading = false
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
        SignUp(uid: Binding.constant(""))
    }
}
