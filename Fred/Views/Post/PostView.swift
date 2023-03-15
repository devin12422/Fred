//
//  PostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct PostView: View {
    let post:Post
    var body: some View {
        let author:User = User(uid: post.author)
        VStack(alignment: .leading) {
            HStack {
                Image("profile-picture").resizable().scaledToFit().frame(width: 40, height: 40).clipShape(Circle())
                Text(author.username).font(.subheadline) .fontWeight(.bold)
                                 
            }.padding(.bottom, 8)
                                
            Text(post.title).font(.title3).fontWeight(.bold)
            Text(post.description).font(.subheadline).foregroundColor(.gray).padding(.bottom, 8)
                             HStack {
                                 Button {
                                 
                                 } label: {
                                     HStack {
                                         Image(systemName: "heart")
                                         Text("Like")
                                     }
                                 }
                                 
                                 Button {
                                 
                                 } label: {
                                     HStack {
                                         Image(systemName: "message")
                                         Text("Comment")
                                     }
                                 }
                             }.padding(.top, 8).foregroundColor(.gray)
                         
                         }.padding().background(Color.white).cornerRadius(10)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post:Post(user: getCurrentUser()))
    }
}
