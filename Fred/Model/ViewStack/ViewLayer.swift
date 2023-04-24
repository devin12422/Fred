//
//  ViewLayer.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/14/23.
//

import Foundation
import SwiftUI


class ViewLayer:ObservableObject,Identifiable,Equatable{
    static func == (lhs: ViewLayer, rhs: ViewLayer) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    var uuid = UUID()
    @Published var radians:CGFloat
    @Published var layer:[ViewState]
    @Published var current_index:Int
    var start_index:Int
    init(layer:[ViewState],index:Int = 0){
        self.layer = layer
        self.current_index = index
        self.start_index = index
        self.radians = -CGFloat(index + 1) / CGFloat(layer.count + 1) + 0.5
        
    }
}
