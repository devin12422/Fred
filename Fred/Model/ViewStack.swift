//
//  ViewStack.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/29/23.
//

import Foundation
import SwiftUI
struct AnyMyView: View {

    private let internalView: AnyView
    let originalView: Any

    init<V: View>(_ view: V) {
        internalView = AnyView(view)
        originalView = view
    }
    
    var body: some View {
        internalView
    }
}

//class ViewWrap
class ViewState:Identifiable,Hashable,ObservableObject{
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    var name:String
    var image:Image
    @Published var view:AnyMyView
    var uuid = UUID()
    init<V:View>(name:String,image:UIImage,view:V) {
        self.name = name
        self.image = Image(uiImage: image)
        self.view = AnyMyView(view)
    }


}
class ViewLayer:ObservableObject,Identifiable,Equatable{
    static func == (lhs: ViewLayer, rhs: ViewLayer) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    var uuid = UUID()
    @Published var layer:[ViewState]
    @Published var current_index:Int
   
    convenience init(layer:[ViewState]){
        self.init(layer:layer,index:0)
    }
    init(layer:[ViewState],index:Int){
        self.layer = layer
        self.current_index = index
    }
}
struct ViewLayerView:View{
    var view_layer:ViewLayer
    var body: some View{
    ForEach(view_layer.layer){
        state in
        let index:CGFloat = getCenteredCircularIndex(layer: view_layer, state: state)
        let image:Image = state.image
        image.offset(x:UIScreen.main.bounds.width * -1 * cos(index),y:UIScreen.main.bounds.width * -1 * sin(index)).padding().background(Color.white).cornerRadius(32)
    }
        
    }
    func getCenteredCircularIndex(layer:ViewLayer,state:ViewState) -> CGFloat{
        return CGFloat(layer.layer.firstIndex(of: state)! + 1) / CGFloat(layer.layer.count + 1) + 1.07
    }
}
class ViewStack:ObservableObject,Identifiable{
    @Published var stack:[ViewLayer]
    init(first_layer:ViewLayer){
        self.stack = [first_layer]
    }
}
