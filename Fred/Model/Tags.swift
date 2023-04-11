//
//  Tags.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/31/23.
//

import Foundation
protocol EquatableEnumCase:Codable,Hashable,CaseIterable,Identifiable{
    
}
extension EquatableEnumCase {

    func isSameCase(as other: Self) -> Bool {
        let mirrorSelf = Mirror(reflecting: self)
        let mirrorOther = Mirror(reflecting: other)
        if let caseSelf = mirrorSelf.children.first?.label, let caseOther = mirrorOther.children.first?.label {
            return (caseSelf == caseOther) //Avoid nil comparation, because (nil == nil) returns true
        } else { return false}
    }
    var string:String{
        return String(describing: Mirror(reflecting:self).children.first!.value)
    }
}
enum MealEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    case Breakfast
    case Lunch
    case Dinner
    case Snacks
}
enum DishEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    static var allCases: [DishEnum] = [MainDish,SideDish,Appetizer,Drink] + DessertTypeEnum.allCases.map(DishEnum.Dessert)
    case MainDish
    case Dessert(DessertTypeEnum?)
    case SideDish
    case Appetizer
    case Drink
    
}
enum DessertTypeEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    static var allCases: [DessertTypeEnum] = [Cookies,Cake,Cupcake,Cheesecake,Brownies,IceCream,Custards,Pie] + PastryTypeEnum.allCases.map(DessertTypeEnum.Pastry)
    case Pastry(PastryTypeEnum?)
    case Cookies
    case Cake
    case Cupcake
    case Cheesecake
    case Brownies
    case IceCream
    case Custards
    case Pie
}
enum PastryTypeEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    case Muffins
    case Scones
    case Bread
}
enum EthnicEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    case Italian
    case French
}
enum OccasionEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    case Christmas
    case NewYear
    case EveryDay
}
enum GenericEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    case BBQ
    case Seafood
}
enum DietEnum:EquatableEnumCase{
    var id:Self{
        return self
    }
    case Vegan
    case Vegetarian
    case GlutenFree
}
enum UniqueTags:EquatableEnumCase{
    static var allCases: [UniqueTags] = MealEnum.allCases.map(UniqueTags.Meal) + DishEnum.allCases.map(UniqueTags.DishType)
    var id:Self{
        return self
    }
    case Meal(MealEnum)
    case DishType(DishEnum)
}
enum Tags:EquatableEnumCase{
    static var allCases: [Tags] = EthnicEnum.allCases.map(Tags.EthnicStyle) + GenericEnum.allCases.map(Tags.Generic) +  DietEnum.allCases.map(Tags.Diet)
    var id:Self{
        return self
    }
   
    
    case EthnicStyle(EthnicEnum)
    case Generic(GenericEnum)
    case Diet(DietEnum)
}
