//
//  ConfigureInterface.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 19/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import Foundation
class ConfigureInterface{
    //Genera Botones
    public func generateButton(x:Int, y:Int, width:Int, height:Int, colorBackground:UIColor, colorBorder:UIColor, tittle:String, tag:Int)->UIButton{
        let buttonConnect = UIButton(frame: CGRect(x:x, y:y, width:width, height:height))
        buttonConnect.layer.cornerRadius = 5
        buttonConnect.layer.borderWidth = 1
        buttonConnect.layer.borderColor = colorBorder.cgColor
        buttonConnect.backgroundColor = colorBackground
        buttonConnect.setTitle(tittle, for: .normal)
        buttonConnect.tag = tag
        return buttonConnect
    }
    
    public func generateButtonCircle(x:Int, y:Int, width:Int, height:Int, colorBackground:UIColor, colorBorder:UIColor, tittle:String, tag:Int)->UIButton{
        let buttonConnect = UIButton(frame: CGRect(x:x, y:y, width:width, height:height))
        buttonConnect.layer.cornerRadius = 0.5 * buttonConnect.bounds.size.width
        buttonConnect.clipsToBounds = true
        buttonConnect.layer.borderWidth = 1
        buttonConnect.layer.borderColor = colorBorder.cgColor
        buttonConnect.backgroundColor = colorBackground
        buttonConnect.setTitle(tittle, for: .normal)
        buttonConnect.imageEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
       //buttonConnect.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        buttonConnect.tag = tag
        return buttonConnect
    }


    public func generateButtonImage(x:Int, y:Int, width:Int, height:Int, colorBackground:UIColor, colorBorder:UIColor, tittle:String, tag:Int)->UIButton{
        let buttonConnect = UIButton(frame: CGRect(x:x, y:y, width:width, height:height))
        //buttonConnect.layer.cornerRadius = 0.5 * buttonConnect.bounds.size.width
       // buttonConnect.clipsToBounds = true
        buttonConnect.layer.borderWidth = 1
        buttonConnect.layer.borderColor = colorBorder.cgColor
        buttonConnect.backgroundColor = colorBackground
        buttonConnect.setTitle(tittle, for: .normal)
        //buttonConnect.imageEdgeInsets = UIEdgeInsetsMake(25,25,25,25)
        //buttonConnect.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        buttonConnect.tag = tag
        return buttonConnect
    }

    //Genera textFields
    public func generateTextField(x:Int, y:Int, width:Int, height:Int, placeholder:String, tagId:Int)->UITextField{
        let someFrame = CGRect(x: x, y: y, width: width, height: height)
        let text = UITextField(frame: someFrame)
        text.borderStyle = UITextBorderStyle.roundedRect
        text.placeholder = placeholder
        text.tag = tagId
        return text
    }
    
    //Genera textFields
    public func generateTextFieldNumeric(x:Int, y:Int, width:Int, height:Int, placeholder:String, tagId:Int)->UITextField{
        let someFrame = CGRect(x: x, y: y, width: width, height: height)
        let text = UITextField(frame: someFrame)
        text.borderStyle = UITextBorderStyle.roundedRect
        text.placeholder = placeholder
        text.tag = tagId
        text.keyboardType = UIKeyboardType.numberPad
        return text
    }
    
    //Genera labels
    public func generateLabel(x:Int, y:Int, width:Int, height:Int, value:String, lines:Int)->UILabel{
        let someFrame = CGRect(x: x, y: y, width: width, height: height)
        let text = UILabel(frame: someFrame)
        text.text = value
        text.numberOfLines = lines
        return text
    }
    
    //Genera imageView
    public func generateImageView(x:Int, y:Int, width:Int, height:Int, imageRoute:String)->UIImageView{
        let imageName = imageRoute
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        return imageView
    }
    
    public func generateImageViewUrl(x:Int, y:Int, width:Int, height:Int, url:String)->UIImageView{
        let imageView = UIImageView()
        let url:String = url
        imageView.af_setImage(withURL: NSURL(string: url) as! URL)
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        return imageView
    }
   
    public func generateImageViewUrlCircle(x:Int, y:Int, width:Int, height:Int, url:String)->UIImageView{
        let imageView = UIImageView()
        let url:String = url
        imageView.af_setImage(withURL: NSURL(string: url) as! URL)
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        imageView.layer.cornerRadius = 0.5 * imageView.bounds.size.width
        imageView.clipsToBounds = true
        //imageView.imageEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
        return imageView
    }

    func convertImageToBW(originalImage:UIImage) -> UIImage {
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        let context = CIContext(options: nil)
        currentFilter!.setValue(CIImage(image: originalImage), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }
    
    //Genera DatePicker
    public func generateDatePicker(x:Int, y:Int, width:Int, height:Int, color: UIColor)->UIDatePicker{
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.frame = CGRect(x: x, y: y, width: width, height: height)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = color
        return datePicker
    }
    
    //Checkbox
    public func generateCheckBox(x:Int, y:Int, width:Int, height:Int, colorBackground:UIColor, colorBorder:UIColor, tittle:String, tag:Int)->CheckBox{
        let buttonConnect = CheckBox(frame: CGRect(x:x, y:y, width:width, height:height))
        buttonConnect.layer.cornerRadius = 0.5 * buttonConnect.bounds.size.width
        buttonConnect.clipsToBounds = true
        buttonConnect.layer.borderWidth = 1
        buttonConnect.layer.borderColor = colorBorder.cgColor
        buttonConnect.backgroundColor = colorBackground
        buttonConnect.setTitle(tittle, for: .normal)
        buttonConnect.imageEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
        //buttonConnect.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        buttonConnect.tag = tag
        return buttonConnect
    }
    
    public func uiPickerView(x:Int, y:Int, width:Int, height:Int, colorBackground:UIColor, colorBorder:UIColor, tittle:String, tag:Int)->UIPickerView{
        let picker = UIPickerView()
        picker.frame = CGRect(x: x, y: y, width: width, height: height)
        picker.backgroundColor = colorBackground
        return picker
    }
}
