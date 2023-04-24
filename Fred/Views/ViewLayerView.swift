//
//  ViewLayerView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/14/23.
//

import SwiftUI

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

struct ViewLayerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewLayerView(view_layer: ViewLayer(layer: []))
    }
}
