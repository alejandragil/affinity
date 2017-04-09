//
//  Strings.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 17/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import Foundation
class Strings {
    //Base endpoints
    let baseUrl = "https://api-loyalty.flecharoja.com/loyalty-api-client/webresources/"
    let singInBaseUrl = "http://idp.flecharoja.com:8080/"
    let grand_type = "password"
    let client_id = "mobile"
    let client_secret = "b2b618ba-cc57-4535-aa0b-4fe18a80a68a"
    //Request endpoints
    let balanceProgress = "v0/perfil/balance/progreso"
    let balanceProfile = "v0/perfil/balance"
    let badgesProfile =  "v0/perfil/insignias"
    let promotion = "v0/promocion"
    let profile = "v0/perfil"
    let leaderboards = "v0/perfil/leaderboards/general"
    let location = "v0/ubicacion"
    let mission =  "v0/mision"
    let reward = "v0/premio"
    let redeemsReward = "v0/premio/redimidos"
    let redeemRewars = "v0/premio/{idPremio}/redimir"
    let categoryProduct = "v0/producto/categoria"
    let product = "v0/producto"
    let store = "v0/ubicacion"
    let productsSubCategory = "v0/producto/categoria/{idSubcategoria}/productos"
    let completeMission = "v0/mision/{idMision}/completar"
    let register = "v0/admin/registro"
    //Promotion
    let ACTION_TYPE_URL = "A";
    let ACTION_TYPE_QR_CODE = "B";
    let ACTION_TYPE_ITF = "C";
    let ACTION_TYPE_EAN = "D";
    let ACTION_TYPE_CODE_128 = "E";
    let ACTION_TYPE_CODE_29 = "F";
    //Challenges
    let TYPE_SURVEY = "E"
    let TYPE_UPDATE_PROFILE = "P"
    let TYPE_SEE_CONTENT = "V"
    let TYPE_UPLOAD_CONTENT = "S"
    let TYPE_SOCIAL_NETWORK = "R"
    //Profile Attribute
    let ATTRIBUTE_TYPE_BIRTH_DATE = "A"
    let ATTRIBUTE_TYPE_GENDER = "B"
    let ATTRIBUTE_TYPE_MARRIAGE_STATUS = "C"
    let ATTRIBUTE_TYPE_NAME = "E"
    let ATTRIBUTE_TYPE_FIRST_NAME = "F"
    let ATTRIBUTE_TYPE_LAST_NAME = "S"
    let ATTRIBUTE_TYPE_CITY = "K"
    let ATTRIBUTE_TYPE_STATE = "L"
    let ATTRIBUTE_TYPE_COUNTRY = "M"
    let ATTRIBUTE_TYPE_PO_BOX = "N"
    let ATTRIBUTE_TYPE_EDUCATION = "O"
    let ATTRIBUTE_TYPE_INCOME = "P"
    let ATTRIBUTE_TYPE_HAVE_CHILD = "Q"
    let ATTRIBUTE_TYPE_DYNAMIC = "R"
    //Profile dinamic atributte
    let DYNAMIC_ATTRIBUTE_TYPE_NUMERIC = "N"
    let DYNAMIC_ATTRIBUTE_TYPE_TEXT = "T"
    let DYNAMIC_ATTRIBUTE_TYPE_BOOLEAN = "B"
    let DYNAMIC_ATTRIBUTE_TYPE_DATE = "F"
    //Challenge Question
    let ANSWER_TYPE_SINGLE_SELECTION = "RU"
    let ANSWER_TYPE_MULTIPLE_SELECTION = "RM"
    let ANSWER_TYPE_INPUT_TEXT = "RT"
    let ANSWER_TYPE_INPUT_NUMBER = "RN"
    //Question type
    let TYPE_INPUT = "E"
    let TYPE_RATING = "C"
    //Challenge See Content
    let CONTENT_TYPE_VIDEO = "V"
    let CONTENT_TYPE_IMAGE = "I"
    let CONTENT_TYPE_URL = "U"
    //Answer type
    
    
}
