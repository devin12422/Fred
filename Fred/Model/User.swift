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
    var username:String = "";
    var email:String = "";
    init(email:String){
        self.email = email;
        self.username = email;
    }
    init(user:User){
        self.username = user.username
        self.email = user.email
    }

    
}
func getCurrentUser()-> User{
    let user = User(email: Auth.auth().currentUser!.email!)
    if Auth.auth().currentUser!.displayName != nil{
        user.username = Auth.auth().currentUser!.displayName!
    }
    return user
}
