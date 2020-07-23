//
//  SandwichModel+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Ahmad Murad on 23/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension SandwichModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SandwichModel> {
        return NSFetchRequest<SandwichModel>(entityName: "SandwichModel")
    }

    @NSManaged public var name: String
    @NSManaged public var imageName: String
    @NSManaged public var sauceAmount: SauceAmountModel

}
