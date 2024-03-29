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

class User:Codable,ObservableObject,Equatable, Hashable,Identifiable{
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case uid
        case image
    }

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    @Published var username:String
    var email:String
    @Published var uid:String?
    // Consider making this optional and removing uid observable environment variable
    @Published var image:Data
    init(email:String = "",username:String? = .none,uid:String? = .none,image:UIImage = UIImage(systemName: "person.crop.circle")!){
        self.email = email;
        if(username != nil){
            self.username = username!;
        }else{
            self.username = email;
        }
        self.uid = uid
        self.image = image.jpegData(compressionQuality: 0.5)!
    }
    func copyTo(from:User){
        self.username = from.username
        self.email = from.email
        self.uid = from.uid
        self.image = from.image
    }
    func get(){
        User.get(uid:self.uid!,completion:copyTo);
    }
    func get_async() async throws{
        self.copyTo(from: await try User.get_async(uid: uid!))
    }
    static func get(uid:String,completion:@escaping (User)->Void) {
        Storage.storage().reference(withPath:"users/\(uid)/user").getData(maxSize: INT64_MAX){
            data, error in
            if(error == nil){
                let decoder = JSONDecoder();
                completion(try! decoder.decode(User.self, from: data!));
            }else{
                print(error!.localizedDescription)
            }
            
        }
    }
    static func get_async(uid:String) async throws-> User {
        return await try withCheckedThrowingContinuation{
            continuation in
            Storage.storage().reference(withPath:"users/\(uid)/user").getData(maxSize: INT64_MAX){
                data, error in
                if(error == nil){
                    let decoder = JSONDecoder();
                    continuation.resume(returning:try! decoder.decode(User.self, from: data!));
                }else{
                    print(error!.localizedDescription)
                    continuation.resume(throwing: error!)
                }
                
            }
        }
    }
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            username = try values.decode(String.self, forKey: .username)
            uid = try values.decode(String.self, forKey: .uid)
            email = try values.decode(String.self, forKey: .email)
            image = try values.decode(Data.self, forKey: .image)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(uid, forKey: .uid)
            try container.encode(image, forKey: .image)
            try container.encode(username, forKey: .username)
            try container.encode(email, forKey: .email)
        }
    func send(){
        let encoder = JSONEncoder();
        let encoded = try? encoder.encode(self);
        Storage.storage().reference().child("users/\(self.uid!)/user").putData(encoded!);
    }
}
