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
    init(user:User){
        self.username = user.username
        self.email = user.email
        self.uid = user.uid
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
