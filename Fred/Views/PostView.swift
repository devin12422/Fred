//
//  PostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI

struct PostView: View {
    @State var post:Post = Post()
    var body: some View {
        VStack{
            TextField("Name",text: $post.title)
            TextField("Description",text: $post.description)
            HStack{
                Button{}label:{Text("Post")}
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
