//
//  FoodDetails.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 28/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct PartialFoodDetails: Codable {
    let foodId: Int
     let foodCode: Int
    let foodName:String
    let energy: String
    let  brandOwner : String
    let source: String
    let quantity:Double
    let servingSize: Double
    
    init(foodId: Int,
         foodCode : Int,
         foodName: String,
         energy : String,
    brandOwner : String,
    source: String,
    quantity:Double,
    servingSize: Double)  {
        self.foodId = foodId
        self.foodCode = foodCode
        self.foodName = foodName
        self.energy = energy
        self.brandOwner = brandOwner
        self.source = source
        self.quantity = quantity
        self.servingSize = servingSize
    }
    init(from decoder: Decoder) throws {
        print("Quantity erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.foodId = try container.decode(Int.self, forKey: .foodId)
        self.foodCode = try container.decode(Int.self, forKey: .foodCode)
        self.foodName = try container.decode(String.self, forKey: .foodName)
        self.energy = try container.decode(String.self, forKey: .energy)
        self.brandOwner = try container.decode(String.self, forKey: .brandOwner)
        self.source = try container.decode(String.self, forKey: .source)
        self.quantity = try container.decode(Double.self, forKey: .quantity)
        self.servingSize = try container.decode(Double.self, forKey: .servingSize)
         
    }
}
struct PartialNutritionixFoodData: Codable {
    
    var common:[PartialCommonFoodData]?
    var branded:[PartialBrandedFoodData]?
}
struct PartialCommonFoodData: Codable {

    let food_name:String
    let  serving_unit : String
    let tag_name: String
    let serving_qty: Float
    let common_type: Int?
    let tag_id: String
    let photo: NutritionixPhoto?
    var locale : String
   
    
}
struct PartialBrandedFoodData: Codable {
    let food_name:String
    let serving_unit : String
    let nix_brand_id: String
    let brand_name_item_name: String
    let serving_qty: Float
    let nf_calories: Double
    let photo: NutritionixPhoto?
    var locale : String
    let  brand_name : String
    let brand_type: Int
    let region: Int
    let nix_item_id: String
    
}
struct FullNutritionixFoodData: Codable {
    
    var foods:[NutritionixFoodData]?
}
struct NutritionixFoodData: Codable {
    let food_name:String
    let serving_unit : String
    let nix_brand_id: String?
    let brand_name_item_name: String? // remove
    let serving_qty: Double
    let nf_calories: Double
    let photo: NutritionixPhoto?
    var locale : String? // remove
    let  brand_name : String?
    let brand_type: Int?
    let region: Int?
    let nix_item_id: String?
    let nix_brand_name: String?
    let nix_item_name: String?
    let serving_weight_grams: Double?
    let nf_total_fat: Double?
    let nf_saturated_fat: Double?
    let nf_cholesterol: Double?
    let nf_sodium: Double?
    let nf_total_carbohydrate: Double?
    let nf_dietary_fiber: Double?
    let nf_sugars: Double?
    let nf_protein: Double?
    let nf_potassium: Double?
    let nf_p: Double?
    var alt_measures: [AlternateMeasures]?
    let upc: String?
    let time: String?
    let createdBy: String?
    let foodStatus:String?
    static var manualFoodData: NutritionixFoodData?
}
struct NewFoodDetails: Codable {
    let foodId: Int
    let foodCode: Int
    let foodName:String
    let  brandOwner : String
    let source: String
    let servingSize: Double
    let createdBy: String
    let units: String
    let imgUrl: String
    var quantity : Quantity?
    var totalFat: NutriInfo?
    var calcium: NutriInfo?
    var energy: NutriInfo?
    var carboHydrate: NutriInfo?
    var protein: NutriInfo?
    var totalFibre: NutriInfo?
    var macors: Macros?
    let actualQuantity: Double
    var dailyValues:DailyValues?
}
struct DailyValues: Codable {
    let carboHydrate_consumed: Float
    let carboHydrate_recommended: Float
    let fat_consumed:Float
    let  fat_recommended : Float
    let fibre_consumed: Float
    let fibre_recommended: Float
    
}
struct NutritionixPhoto: Codable {
    let thumb: String?
    
}
struct AlternateMeasures: Codable {
    let serving_weight: Double?
    let measure: String?
    let seq: Int?
    let qty: Float
}
