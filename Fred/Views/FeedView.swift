//
//  PostListView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import BackgroundTasks
import FirebaseStorage
import FirebaseAuth

enum FeedState{
    case Loading
    case Loaded
    case Error
}
struct ListView<ListItemType:Feedable>: View{
    @State var posts:[CodableWrapper<ListItemType>] = [];
    @State var feed_state:FeedState = .Loading
    @State var page_token:String = ""
    var path:String
    var max_results_from_same_user:Int64
    var body: some View {
        VStack{
            if(posts.count == 0 && feed_state == .Loading){
                Text("Loading")
            }
            switch feed_state {
            case .Error:
                Text("An unknown error occurred")
            default:
                List(posts){post in
                    post.wrapped.getView(author: post.author)
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
        Storage.storage().reference().child(path).list(maxResults:8,pageToken: page_token,completion:{(result,error) in
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
                    print("user:\(pfx.name)")
                    User.get(uid:pfx.name){user in
                        pfx.list(maxResults:max_results_from_same_user){(post_list_data,error) in
                            for item in post_list_data!.prefixes {
                                print(item.name)
                                
                                item.child("item").getData(maxSize: Int64.max){
                                    (item_data,error)in
                                    if error != nil {
                                        print(error!.localizedDescription)
                                        feed_state = .Error
                                    }else{
                                        guard let item = try? decoder.decode(ListItemType.self, from: item_data!)
                                        else{
                                            print("error decoding item");
                                            feed_state = .Error
                                            return;
                                        }
                                        posts.append(CodableWrapper<ListItemType>(wrapped:item,author:user))
                                        print(item)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                feed_state = .Loaded
                
            }
        })
    }
}
