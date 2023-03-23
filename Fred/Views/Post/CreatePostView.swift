//
//  CreatePostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth
struct PostCreateView: View {
    @State var post:Post = Post(user: getCurrentUser())
    @State var showAlert: Bool = false
    var body: some View {
        VStack{
            Text("Enter a Title for the post")
            TextField("Name",text: $post.title)
            Text("Please make a description for the post")
            TextField("Description",text: $post.description)
            HStack{
                Button{
                    guard let uid = Auth.auth().currentUser?.uid else{return}
                    let encoder = JSONEncoder();
                    let encoded = try? encoder.encode(post);

                    Storage.storage().reference().child("posts/\(uid)/\(post.uuid)").putData(encoded!);
                }label:{Text("Post")}
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Your post has been created."),
                    dismissButton: .default(Text("OK"))
                )
            }
            Spacer()
        }.navigationBarTitle(Text("Create Post"), displayMode: .inline)
    }
}
           
struct PostCreateView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateView()
    }
}
