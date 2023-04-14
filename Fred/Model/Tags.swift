//
//  Tags.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/31/23.
//

import Foundation
struct TagType:Codable,Hashable,Identifiable{
    var name:String
    var cases:Set<TagInstance>
    var isUnique:Bool
    static var ALL_TAGS:Set<TagType> = [];
    init(name:String,cases:Set<TagInstance>,isUnique:Bool){
        self.name = name
        self.cases = cases
        self.isUnique = isUnique
        Self.ALL_TAGS.insert(self)
    }
    init(name:String,cases:Set<String>,isUnique:Bool){
        self.name = name
        self.cases = []
        self.isUnique = isUnique

        cases.forEach{instance in
            self.cases.insert(TagInstance(tag_type: self, tag: instance))
        }
        Self.ALL_TAGS.insert(self)
    }
    var id:  String {get{return name}}
}
struct TagInstance:Codable,Hashable,Identifiable{
    var tag_type:TagType
    var tag:String
    var id:String{get{return tag}}
}
