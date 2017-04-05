//
//  Store.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 17/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import Foundation

class Store {
    var  idUbicacion:String = ""
    var  nombre:String = ""
    var  indDirPais:String = ""
    var  indDirEstado:String = ""
    var  indDirCiudad:String = ""
    var  direccion:String = ""
    var  horarioAtencion:String = ""
    var  telefono:String = ""
    var  dirLat:Float = 0.0
    var  dirLng:Float = 0.0
    var zones:Array<Zone> = [ ]
}
