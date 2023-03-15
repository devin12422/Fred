//
//  User.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//
import FirebaseAuth
import Foundation
import SwiftUI
import FirebaseCore
import FirebaseStorage
class User:Codable,ObservableObject{
    var username:String = ""
    var email:String = ""
    var uid:String = ""
    init(email:String,username:String? = .none){
        self.email = email;
        if(username != nil){
            self.username = username!;
        }else{
            self.username = email;
        }
        self.uid = ""
    }
    init(from:User){
        self.username = from.username
        self.email = from.email
        self.uid = from.uid
    }
    init(uid:String){
        Storage.storage().reference(withPath:"users/\(uid)").getData(maxSize: INT64_MAX){ [self]
            data, error in
            if(error == nil){
                let decoder = JSONDecoder();
                let u = try! decoder.decode(User.self, from: data!);
                copyTo(from: u, to: self)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    func copyTo(from:User,to:User){
        to.uid = from.uid
        to.username = from.username
        to.email = from.email
    }

    
}
func getCurrentUser()-> User{
    let user = User(email: Auth.auth().currentUser!.email!)
    if Auth.auth().currentUser!.displayName != nil{
        user.username = Auth.auth().currentUser!.displayName!
    }
    user.uid = (Auth.auth().currentUser?.uid)!

    return user
}
