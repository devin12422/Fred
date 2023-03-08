//
//  PostDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI


struct PostDetailView: View {
    var post:Post
    var body: some View {
        VStack{
            Text(post.title)
            Text(post.author.email)
            Text(post.description)
            List(post.instructions){instruction in
                Text(instruction.string)
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post())
    }
}
