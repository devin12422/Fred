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
    var post:Post
    var body: some View {
        VStack{
            Text(post.title)
            Text(post.author.email)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post:Post())
    }
}
