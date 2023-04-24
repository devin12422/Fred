//
//  UserView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/22/23.
//

import SwiftUI

struct UserView: View {
    var user:User
    @EnvironmentObject var view_stack:ViewStack
    var body: some View {
        Button{
            view_stack.stack.append(ViewLayer(layer:[ViewState(name:"Reviews",image:UIImage(systemName: "star.fill")!,view:PostCreateView()),ViewState(name:"About",image:UIImage(data:user.image)!,view:UserDetailView(user: user)),ViewState(name:"Posts",image:UIImage(systemName: "tray.full")!,view:QuickFeed(user:user, max_results_from_same_user: 64))]))
        }label:{HStack {
            Image(uiImage:UIImage(data:user.image)!).resizable().frame(width: 40, height: 40).clipShape(Circle())
            Text(user.username).font(.subheadline) .fontWeight(.bold)
            
        }.padding(.bottom, 8)}
    }
}
import SwiftUI
import BackgroundTasks
import FirebaseStorage
import FirebaseAuth
struct QuickFeed:View{
    enum FeedState{
        case Loading
        case Loaded
        case Error
    }
    @State var posts:[CodableWrapper<Post>] = [];
    @State var feed_state:FeedState = .Loading
    @State var page_token:String = ""
    var user:User
    var max_results_from_same_user:Int64
    var body: some View{
        
        VStack{
            if(posts.count == 0 && feed_state == .Loading){
                Text("Loading")
            }
            switch feed_state {
            case .Error:
                Text("An unknown error occurred")
            default:NavigationView{
                List(posts){post in
                    post.wrapped.getView(author: post.author)
                }
            }
                
            }
        }.task{
            if(feed_state == .Loading){
                getPosts()
            }
        }
    }
    func getPosts(){
        print("fetching items")
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: "GTMSessionFetcher-firebasestorage.googleapis.com")
        Storage.storage().reference().child("posts/\(user.uid!)").list(maxResults:8,pageToken: page_token,completion:{(result,error) in
            if let error = error {
                print(error.localizedDescription)
                feed_state = .Error
            }else{
                if result?.pageToken != .none{
                    page_token = (result?.pageToken!)!
                }
                let decoder = JSONDecoder()
                print("decoding items")
                for pfx in result!.prefixes {
                    
                    pfx.child("item").getData(maxSize: Int64.max){
                        (item_data,error)in
                        if error != nil {
                            print(error!.localizedDescription)
                            feed_state = .Error
                        }else{
                            guard let item = try? decoder.decode(Post.self, from: item_data!)
                            else{
                                print("error decoding item");
                                feed_state = .Error
                                return;
                            }
                            posts.append(CodableWrapper<Post>(wrapped:item,author:user))
                            print(item)
                            
                        }
                    }
                    
                }
                feed_state = .Loaded
                
            }
        })
    }
    
}
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:User())
    }
}
