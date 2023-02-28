//
//  User.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//
import FirebaseAuth
import Foundation
class User{
    static var current:User?;
    var username:String;
    var email:String;
    init(email:String){
        self.email = email;
        self.username = email;
    }
    static func signIn(){}
    
}
