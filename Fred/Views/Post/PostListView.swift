//
//  PostListView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct PostListView: View {
    @State var posts:[Post] = [];
        
    var body: some View {
        VStack{
            Text("Posts")
            NavigationView{
                List(posts){post in

                    NavigationLink{
                        PostDetailView(post: post)
                    }label:{
                        PostView(post: post)
                    }
            }
                
            }
        }.task{
            
            Storage.storage().reference().child("posts").list(maxResults:16){(result,error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    let decoder = JSONDecoder()

                for prefix in result!.prefixes {
                    print(prefix.fullPath)
                    prefix.list(maxResults:64){(result,error) in
                        for item in result!.items {
                            item.getData(maxSize: Int64.max){
                                (result,error)in
                                if let error = error {
                                    print(error.localizedDescription)
                                }else{
                                    let p = try? decoder.decode(Post.self, from: result!);
                                    posts.append(p!)


                                }

                            }
                    }
                    // The prefixes under storageReference.
                    // You may call listAll(completion:) recursively on them.
                  }
                for item in result!.items {
                    item.getData(maxSize: Int64.max){(result,error)in
                        if let error = error {
                            print(error.localizedDescription)
                        }else{
                            let p = try? decoder.decode(Post.self, from: result!);
                            posts.append(p!)


                        }

                    }
                    // The items under storageReference.
                }}
                }
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}

