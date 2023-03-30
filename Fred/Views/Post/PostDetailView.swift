//
//  PostDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI


struct PostDetailView: View {
    let post:PostWrapper
    var body: some View {
        VStack{
            Text(post.post.title)
            NavigationLink{
                UserDetailView(user: post.author)
            }label:{
                UserView(user:post.author)
            }
            Text(post.post.description)
            List(post.post.instructions){instruction in
                Text(instruction.string)
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: PostWrapper(post: Post(), author: User()))
    }
}
