//
//  Challenge.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 24/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import Foundation
class Challenge {
    var idMision = ""
    var encabezadoArte = ""
    var subencabezadoArte = ""
    var detalleArte = ""
    var imagenArte = ""
    var cantMetrica = 000000
    var indTipoMision = ""
    var metrica = Metric()
    var misionVerContenido = ChallengesSeeContent()
    var misionPerfilAtributos = [ChallengesProfileAttribute]()
    var misionEncuestaPreguntas = [ChallengeQuestion]()
    //var misionRedSocial = ChallengeSocialNetwork()
    //var misionSubirContenido = ChallengeUploadContent()
}
