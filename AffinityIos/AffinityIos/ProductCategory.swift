//
//  ProductCategory.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 17/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import Foundation

class ProductCategory{
    var idCategoria:String = ""
    var nombre:String = ""
    var imagen:String = ""
    var descripcion:String = ""
    var subcategories:Array<ProductSubcategory> = [ ]
}
