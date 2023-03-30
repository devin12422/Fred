//
//  ViewStack.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/29/23.
//

import Foundation
import SwiftUI

class ViewState:Identifiable,Hashable{
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    var name:String
    var image:Image
    var view:AnyView
    var uuid = UUID()
    init<T:View>(name:String,image:UIImage,view:T) {
        self.name = name
        self.image = Image(uiImage: image)
        self.view = AnyView(view)
    }
    convenience init(){
        self.init(name:"Home",image:UIImage(systemName: "house")!,view:PostListView())
    }
    
}
class ViewLayer:ObservableObject,Identifiable,Equatable{
    static func == (lhs: ViewLayer, rhs: ViewLayer) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    var uuid = UUID()
    @Published var layer:[ViewState]
    @Published var current_index:Int
    convenience init(){
        self.init(layer: [ViewState(name:"Post Create",image:UIImage(systemName: "doc.text")!,view:PostCreateView()),ViewState(name:"Home",image:UIImage(systemName: "house")!,view:PostListView()),ViewState(name:"Settings",image:UIImage(systemName: "gear")!,view:SettingsView())])

    }
    convenience init(layer:[ViewState]){
        self.init(layer:layer,index:0)
    }
    init(layer:[ViewState],index:Int){
        self.layer = layer
        self.current_index = index
    }
}
class ViewStack:ObservableObject,Identifiable{
    @Published var stack:[ViewLayer]
    init(){
        self.stack = [ViewLayer()]
    }
}
