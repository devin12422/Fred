//
//  PostDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI


struct PostDetailView: View {
    let post:Post
    var body: some View {
        let author:User = User(uid: post.author)

        VStack{
            Text(post.title)
            Text(author.username)
        
            Text(post.description)
            List(post.instructions){instruction in
                Text(instruction.string)
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post(user:getCurrentUser()))
    }
}
