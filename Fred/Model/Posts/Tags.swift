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
    static var ALL_TAGS:Set<TagType>{get{
        return [TagType(name:"Meal",cases:["Breakfast","Lunch","Dinner"],isUnique: true),
        TagType(name:"Ethnicity",cases:["Italian","French","American","Hispanic"],isUnique: true),
        TagType(name:"Restrictions",cases:["Vegan","Vegetarian","Gluten Free"],isUnique: false)]
    }}
    init(name:String,cases:Set<TagInstance>,isUnique:Bool){
        self.name = name
        self.isUnique = isUnique
        self.cases = []
        cases.forEach{instance in
            var new_instance = instance
            new_instance.tag_type = self
            self.cases.insert(new_instance)
        }
    }
    init(name:String,cases:Set<String>,isUnique:Bool){
        self.name = name
        self.cases = []
        self.isUnique = isUnique

        cases.forEach{instance in
            self.cases.insert(TagInstance(tag_type: self, tag: instance))
        }
    }
    var id:  String {get{return name}}
}
struct TagInstance:Codable,Hashable,Identifiable{
    var tag_type:TagType
    var tag:String
    var id:String{get{return tag}}
}
