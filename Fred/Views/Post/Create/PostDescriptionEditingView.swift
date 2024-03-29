//
//  PostDescriptionEditingView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/23/23.
//

import Foundation

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct PostDescriptionEditingView: View {
    @ObservedObject var post:Post
    @State var tag_view: AnyView = AnyView(EmptyView())
    @State var posted = false
    @State var loading = false
    @State var tag_is_showing  = false
    
    var body: some View {
        VStack{
            Group{
                Text("New Recipe")
                TextField("Name",text: $post.title)
            }
            HStack{
                Text("Tags:")
                ScrollView(.horizontal){
                    HStack{
                        tag_view
                        Button{
                            tag_is_showing.toggle()
                        }label:{
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
            
            Text("Please make a description for the post")
            TextField("Description",text: $post.description)
                .sheet(isPresented: $tag_is_showing){
                    ScrollView{
                        ForEach(getTagTypes().shuffled()){type in
                            VStack{
                                Text(type.name)
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(type.cases.shuffled(),id:\.self){ instance in
                                            Button{
                                                post.tags.insert(instance)
                                                tag_is_showing.toggle()
                                                tag_view = AnyView(generateTagView())
                                            }label:{
                                                Text(instance.tag)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
            Button{
                if(post.isComplete() && !loading){
                    loading = true
                    guard let uid = Auth.auth().currentUser?.uid else{return}
                    let encoder = JSONEncoder();
                    let encoded = try? encoder.encode(post);
                    Storage.storage().reference().child("posts/\(uid)/\(post.uuid)/item").putData(encoded!){
                        _, error in
                        if error == nil{
                            posted = true
                            loading = false
                        }else{
                            print(error!.localizedDescription)
                        }
                    }
                    
                }
            }label:{Text("Post")}
                .alert(isPresented: $posted) {Alert(title: Text("Success"), message: Text("Your post has been created."),dismissButton: .default(Text("Ok")){
                    tag_view = AnyView(EmptyView())
                    post.reset()})}
        }
    }
    func getTagTypes() -> Set<TagType> {
        var existing_types:Set<TagType> = []
        for tag in post.tags{
            if(tag.tag_type.isUnique){
                existing_types.insert(tag.tag_type)
                // print(tag.tag_type.id)
            }
            
        }
        //        print(TagType.ALL_TAGS.subtracting(existing_types))
        return TagType.ALL_TAGS.subtracting(existing_types)
    }
    func generateTagView() -> some View{
        return ForEach(post.tags.shuffled(),id:\.self.tag){tag in
            VStack{
                Button{
                    post.tags.remove(tag)
                    tag_view = AnyView(generateTagView())
                }label:{Text(tag.tag)}}
        }
    }
}
