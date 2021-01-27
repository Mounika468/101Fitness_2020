//
//  MealPlan.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 20/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
//
//  DayWorkOuts.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 26/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct Diet: Decodable {

    let day: Int?
    let program_id: String?
    let trainee_id: String
    var mealplan: Mealplan?
    
    init(day: Int?,program_id: String?, trainee_id: String)  {
                self.day = day
         self.program_id = program_id
         self.trainee_id = trainee_id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decodeIfPresent(Int.self, forKey: .day)
        self.mealplan = try container.decodeIfPresent(Mealplan.self, forKey: .mealplan)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
         self.program_id = try container.decodeIfPresent(String.self, forKey: .program_id)
    }
}
extension Diet {
    
    enum CodingKeys: String, CodingKey {
        case day
        case program_id
        case trainee_id
         case mealplan
    }
}
//MARK: To parse Workouts
struct Mealplan: Decodable {
   
    var breakfast: Breakfast?
     var lunch: Lunch?
    var snacks_2: Snacks_2?
    var dinner: Dinner?
    var snacks : Snacks?
     var waterConsumed: WaterConsumed?
    var macros: Macros?
    let overall_carboHydrate_consumed: Double
    let overall_carboHydrate_recommended: Double
    let overall_calories_consumed: Double
    let overall_calories_recommended: Double
    let overall_fat_consumed: Double
    let overall_fat_recommended: Double
    let overall_protein_consumed: Double
    let overall_protein_recommended: Double
    let mealPlanStatus: String?
    let mealName: String?

    init( overall_carboHydrate_consumed: Double,
     overall_carboHydrate_recommended: Double,
     overall_calories_consumed: Double,
     overall_calories_recommended: Double,
     overall_fat_consumed: Double,
     overall_fat_recommended: Double,
     overall_protein_consumed: Double,
     overall_protein_recommended: Double,
     mealPlanStatus: String?,
     mealName: String? )  {
        
        self.overall_carboHydrate_consumed = overall_carboHydrate_consumed
        self.overall_carboHydrate_recommended = overall_carboHydrate_recommended
        self.overall_calories_consumed = overall_calories_consumed
        self.overall_calories_recommended = overall_calories_recommended
        self.overall_fat_consumed = overall_fat_consumed
        self.overall_fat_recommended = overall_fat_recommended
        self.overall_protein_consumed = overall_protein_consumed
        self.overall_protein_recommended = overall_protein_recommended
        self.mealPlanStatus = mealPlanStatus
        self.mealName = mealName
        
    }
    init(from decoder: Decoder) throws {
        print("MeqalPlan erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.breakfast = try container.decodeIfPresent(Breakfast.self, forKey: .breakfast)
        self.lunch = try container.decodeIfPresent(Lunch.self, forKey: .lunch)
        self.snacks_2 = try container.decodeIfPresent(Snacks_2.self, forKey: .snacks_2)
        self.dinner = try container.decodeIfPresent(Dinner.self, forKey: .dinner)
        self.snacks = try container.decodeIfPresent(Snacks.self, forKey: .snacks)
        self.waterConsumed = try container.decodeIfPresent(WaterConsumed.self, forKey: .waterConsumed)
        self.macros = try container.decodeIfPresent(Macros.self, forKey: .macros)
        self.overall_carboHydrate_consumed = try container.decode(Double.self, forKey: .overall_carboHydrate_consumed)
        self.overall_carboHydrate_recommended = try container.decode(Double.self, forKey: .overall_carboHydrate_recommended)
        self.overall_calories_consumed = try container.decode(Double.self, forKey: .overall_calories_consumed)
        self.overall_calories_recommended = try container.decode(Double.self, forKey: .overall_calories_recommended)
        self.overall_fat_consumed = try container.decode(Double.self, forKey: .overall_fat_consumed)
        self.overall_fat_recommended = try container.decode(Double.self, forKey: .overall_fat_recommended)
        self.overall_protein_consumed = try container.decode(Double.self, forKey: .overall_protein_consumed)
        self.overall_protein_recommended = try container.decode(Double.self, forKey: .overall_protein_recommended)
        self.mealPlanStatus = try container.decodeIfPresent(String.self, forKey: .mealPlanStatus)
        self.mealName = try container.decodeIfPresent(String.self, forKey: .mealName)
        
    }
}
extension Mealplan {
    
    enum CodingKeys: String, CodingKey {
        case breakfast
        case lunch
        case snacks_2
        case dinner
        case snacks
        case waterConsumed
        case overall_carboHydrate_consumed
        case overall_carboHydrate_recommended
        case overall_calories_consumed
        case overall_calories_recommended
        case overall_fat_consumed
        case overall_fat_recommended
        case overall_protein_consumed
        case overall_protein_recommended
        case mealPlanStatus
        case  mealName
         case  macros
        
    }
}
//MARK: To parse Workouts Names
struct NutriInfo: Codable {
    let per_serving: Float?
    let recommended: Float
    let consumed: Float
    
    
    init(per_serving: Float?,
     recommended: Float ,
     consumed: Float)  {
        
        self.per_serving = per_serving
        self.recommended = recommended
        self.consumed = consumed
        
    }
    init(from decoder: Decoder) throws {
        print("Nutrition erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.per_serving = try container.decodeIfPresent(Float.self, forKey: .per_serving)
        self.recommended = try container.decode(Float.self, forKey: .recommended)
        self.consumed = try container.decode(Float.self, forKey: .consumed)
    }
}
//MARK: To parse BreakFast
struct Breakfast: Codable {
    let overall_protein_recommended: Float?
    let overall_carboHydrate_recommended: Float?
      let overall_fibre_recommended: Float?
      let overall_fat_recommended: Float?
      let overall_calcium_recommended: Float?
      let overall_calories_recommended: Float?
    let overall_protein_consumed: Float?
    let overall_carboHydrate_consumed : Float?
    let overall_fibre_consumed: Float?
     let overall_fat_consumed: Float?
    let overall_calories_consumed: Float?
    let overall_calcium_consumed: Float?
     var foodItems: [NutritionixFoodItems]?
     var macros: Macros?
    init(overall_protein_recommended: Float?,
         overall_carboHydrate_recommended: Float?,
          overall_fibre_recommended: Float?,
            overall_fat_recommended: Float?,
            overall_calcium_recommended : Float?,
            overall_calories_recommended: Float?,
            overall_protein_consumed: Float?,
            overall_carboHydrate_consumed:Float?,
            overall_fibre_consumed:Float?,
            overall_fat_consumed:Float?,
            overall_calcium_consumed:Float?,
            overall_calories_consumed:Float?)  {
        
        self.overall_protein_recommended = overall_protein_recommended
        self.overall_carboHydrate_recommended = overall_carboHydrate_recommended
        self.overall_fibre_recommended = overall_fibre_recommended
               self.overall_fat_recommended = overall_fat_recommended
               self.overall_calcium_recommended = overall_calcium_recommended
               self.overall_calories_recommended = overall_calories_recommended
         self.overall_protein_consumed = overall_protein_consumed
        self.overall_carboHydrate_consumed = overall_carboHydrate_consumed
        self.overall_fibre_consumed = overall_fibre_consumed
        self.overall_fat_consumed = overall_fat_consumed
        self.overall_calcium_consumed = overall_calcium_consumed
        self.overall_calories_consumed = overall_calories_consumed
   
    }
    init(from decoder: Decoder) throws {
        print("Bf exercises erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall_protein_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_protein_recommended)
        self.overall_carboHydrate_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_recommended)
        self.overall_fibre_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_recommended)
        self.overall_fat_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fat_recommended)
        self.overall_calcium_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_recommended)
        self.overall_calories_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calories_recommended)
        self.overall_protein_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_protein_consumed)
        self.overall_carboHydrate_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_consumed)
        self.overall_fibre_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_consumed)
        self.overall_fat_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fat_consumed)
        self.overall_calcium_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_consumed)
        self.overall_calories_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calories_consumed)
        self.foodItems = try container.decodeIfPresent([NutritionixFoodItems].self, forKey: .foodItems)
        self.macros = try container.decodeIfPresent(Macros.self, forKey: .macros)
       
    }
}
extension Breakfast {
    
    enum Breakfast: String, CodingKey {
        case overall_protein_recommended
        case overall_carboHydrate_recommended
        case overall_fibre_recommended
        case overall_fat_recommended
        case overall_calcium_recommended
        case overall_calories_recommended
        case overall_protein_consumed
        case overall_carboHydrate_consumed
        case overall_fibre_consumed
        case overall_fat_consumed
        case overall_calories_consumed
        case overall_calcium_consumed
        case foodItems
        case macros
    }
}
//MARK: To parse BreakFast
struct Lunch: Codable {
    let overall_protein_recommended: Float?
    let overall_carboHydrate_recommended: Float?
//    var overall_fibre_recommended: [Sets]?
//    var exerciseVideo : ExerciseVideo?
      let overall_fibre_recommended: Float?
      let overall_fat_recommended: Float?
      let overall_calcium_recommended: Float?
      let overall_calories_recommended: Float?
    let overall_protein_consumed: Float?
    let overall_carboHydrate_consumed : Float?
    let overall_fibre_consumed: Float?
     let overall_fat_consumed: Float?
    let overall_calories_consumed: Float?
    let overall_calcium_consumed: Float?
     var foodItems: [NutritionixFoodItems]?
     var macros: Macros?
    init(overall_protein_recommended: Float?,
         overall_carboHydrate_recommended: Float?,
          overall_fibre_recommended: Float?,
            overall_fat_recommended: Float?,
            overall_calcium_recommended : Float?,
            overall_calories_recommended: Float?,
            overall_protein_consumed: Float?,
            overall_carboHydrate_consumed:Float?,
            overall_fibre_consumed:Float?,
            overall_fat_consumed:Float?,
            overall_calcium_consumed:Float?,
            overall_calories_consumed:Float?)  {
        
        self.overall_protein_recommended = overall_protein_recommended
        self.overall_carboHydrate_recommended = overall_carboHydrate_recommended
        self.overall_fibre_recommended = overall_fibre_recommended
               self.overall_fat_recommended = overall_fat_recommended
               self.overall_calcium_recommended = overall_calcium_recommended
               self.overall_calories_recommended = overall_calories_recommended
         self.overall_protein_consumed = overall_protein_consumed
        self.overall_carboHydrate_consumed = overall_carboHydrate_consumed
        self.overall_fibre_consumed = overall_fibre_consumed
        self.overall_fat_consumed = overall_fat_consumed
        self.overall_calcium_consumed = overall_calcium_consumed
        self.overall_calories_consumed = overall_calories_consumed
     
    }
    init(from decoder: Decoder) throws {
        print("Lunch exercises erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall_protein_recommended = try container.decode(Float.self, forKey: .overall_protein_recommended)
        self.overall_carboHydrate_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_recommended)
        self.overall_fibre_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_recommended)
        self.overall_fat_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fat_recommended)
        self.overall_calcium_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_recommended)
        self.overall_calories_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calories_recommended)
        self.overall_protein_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_protein_consumed)
        self.overall_carboHydrate_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_consumed)
        self.overall_fibre_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_consumed)
        self.overall_fat_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fat_consumed)
        self.overall_calcium_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_consumed)
        self.overall_calories_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calories_consumed)
        self.foodItems = try container.decodeIfPresent([NutritionixFoodItems].self, forKey: .foodItems)
        self.macros = try container.decodeIfPresent(Macros.self, forKey: .macros)
       
    }
}
extension Lunch {
    
    enum Lunch: String, CodingKey {
        case overall_protein_recommended
        case overall_carboHydrate_recommended
        case overall_fibre_recommended
        case overall_fat_recommended
        case overall_calcium_recommended
        case overall_calories_recommended
        case overall_protein_consumed
        case overall_carboHydrate_consumed
        case overall_fibre_consumed
        case overall_fat_consumed
        case overall_calories_consumed
        case overall_calcium_consumed
        case foodItems
        case macros
    }
}
struct Dinner: Codable {
    let overall_protein_recommended: Float?
    let overall_carboHydrate_recommended: Float?
//    var overall_fibre_recommended: [Sets]?
//    var exerciseVideo : ExerciseVideo?
      let overall_fibre_recommended: Float?
      let overall_fat_recommended: Float?
      let overall_calcium_recommended: Float?
      let overall_calories_recommended: Float?
    let overall_protein_consumed: Float?
    let overall_carboHydrate_consumed : Float?
    let overall_fibre_consumed: Float?
     let overall_fat_consumed: Float?
    let overall_calories_consumed: Float?
    let overall_calcium_consumed: Float?
     var foodItems: [NutritionixFoodItems]?
     var macros: Macros?
    init(overall_protein_recommended: Float?,
         overall_carboHydrate_recommended: Float?,
          overall_fibre_recommended: Float?,
            overall_fat_recommended: Float?,
            overall_calcium_recommended : Float?,
            overall_calories_recommended: Float?,
            overall_protein_consumed: Float?,
            overall_carboHydrate_consumed:Float?,
            overall_fibre_consumed:Float?,
            overall_fat_consumed:Float?,
            overall_calcium_consumed:Float?,
            overall_calories_consumed:Float?)  {
        
        self.overall_protein_recommended = overall_protein_recommended
        self.overall_carboHydrate_recommended = overall_carboHydrate_recommended
        self.overall_fibre_recommended = overall_fibre_recommended
               self.overall_fat_recommended = overall_fat_recommended
               self.overall_calcium_recommended = overall_calcium_recommended
               self.overall_calories_recommended = overall_calories_recommended
         self.overall_protein_consumed = overall_protein_consumed
        self.overall_carboHydrate_consumed = overall_carboHydrate_consumed
        self.overall_fibre_consumed = overall_fibre_consumed
        self.overall_fat_consumed = overall_fat_consumed
        self.overall_calcium_consumed = overall_calcium_consumed
        self.overall_calories_consumed = overall_calories_consumed
     
    }
    init(from decoder: Decoder) throws {
        print("Dinner exercises erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall_protein_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_protein_recommended)
        self.overall_carboHydrate_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_recommended)
        self.overall_fibre_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_recommended)
        self.overall_fat_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fat_recommended)
        self.overall_calcium_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_recommended)
        self.overall_calories_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calories_recommended)
        self.overall_protein_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_protein_consumed)
        self.overall_carboHydrate_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_consumed)
        self.overall_fibre_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_consumed)
        self.overall_fat_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fat_consumed)
        self.overall_calcium_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_consumed)
        self.overall_calories_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calories_consumed)
        self.foodItems = try container.decodeIfPresent([NutritionixFoodItems].self, forKey: .foodItems)
        self.macros = try container.decodeIfPresent(Macros.self, forKey: .macros)
       
    }
}
extension Dinner {
    
    enum Dinner: String, CodingKey {
        case overall_protein_recommended
        case overall_carboHydrate_recommended
        case overall_fibre_recommended
        case overall_fat_recommended
        case overall_calcium_recommended
        case overall_calories_recommended
        case overall_protein_consumed
        case overall_carboHydrate_consumed
        case overall_fibre_consumed
        case overall_fat_consumed
        case overall_calories_consumed
        case overall_calcium_consumed
        case foodItems
      case macros
        
    }
}
struct Snacks_2: Codable {
    let overall_protein_recommended: Float?
    let overall_carboHydrate_recommended: Float?
//    var overall_fibre_recommended: [Sets]?
//    var exerciseVideo : ExerciseVideo?
      let overall_fibre_recommended: Float?
      let overall_fat_recommended: Float?
      let overall_calcium_recommended: Float?
      let overall_calories_recommended: Float?
    let overall_protein_consumed: Float?
    let overall_carboHydrate_consumed : Float?
    let overall_fibre_consumed: Float?
     let overall_fat_consumed: Float?
    let overall_calories_consumed: Float?
    let overall_calcium_consumed: Float?
     var foodItems: [NutritionixFoodItems]?
    init(overall_protein_recommended: Float?,
         overall_carboHydrate_recommended: Float?,
          overall_fibre_recommended: Float?,
            overall_fat_recommended: Float?,
            overall_calcium_recommended : Float?,
            overall_calories_recommended: Float?,
            overall_protein_consumed: Float?,
            overall_carboHydrate_consumed:Float?,
            overall_fibre_consumed:Float?,
            overall_fat_consumed:Float?,
            overall_calcium_consumed:Float?,
            overall_calories_consumed:Float?)  {
        
        self.overall_protein_recommended = overall_protein_recommended
        self.overall_carboHydrate_recommended = overall_carboHydrate_recommended
        self.overall_fibre_recommended = overall_fibre_recommended
               self.overall_fat_recommended = overall_fat_recommended
               self.overall_calcium_recommended = overall_calcium_recommended
               self.overall_calories_recommended = overall_calories_recommended
         self.overall_protein_consumed = overall_protein_consumed
        self.overall_carboHydrate_consumed = overall_carboHydrate_consumed
        self.overall_fibre_consumed = overall_fibre_consumed
        self.overall_fat_consumed = overall_fat_consumed
        self.overall_calcium_consumed = overall_calcium_consumed
        self.overall_calories_consumed = overall_calories_consumed
       
    }
    init(from decoder: Decoder) throws {
        print("Snacks_2 exercises erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall_protein_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_protein_recommended)
        self.overall_carboHydrate_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_recommended)
        self.overall_fibre_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_recommended)
        self.overall_fat_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fat_recommended)
        self.overall_calcium_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_recommended)
        self.overall_calories_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calories_recommended)
        self.overall_protein_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_protein_consumed)
        self.overall_carboHydrate_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_consumed)
        self.overall_fibre_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_consumed)
        self.overall_fat_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fat_consumed)
        self.overall_calcium_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_consumed)
        self.overall_calories_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calories_consumed)
        self.foodItems = try container.decodeIfPresent([NutritionixFoodItems].self, forKey: .foodItems)
       
    }
}
extension Snacks_2 {
    
    enum Snacks_2: String, CodingKey {
        case overall_protein_recommended
        case overall_carboHydrate_recommended
        case overall_fibre_recommended
        case overall_fat_recommended
        case overall_calcium_recommended
        case overall_calories_recommended
        case overall_protein_consumed
        case overall_carboHydrate_consumed
        case overall_fibre_consumed
        case overall_fat_consumed
        case overall_calories_consumed
        case overall_calcium_consumed
        case foodItems
      
        
    }
}
struct Snacks: Codable {
    let overall_protein_recommended: Float?
    let overall_carboHydrate_recommended: Float?
//    var overall_fibre_recommended: [Sets]?
//    var exerciseVideo : ExerciseVideo?
      let overall_fibre_recommended: Float?
      let overall_fat_recommended: Float?
      let overall_calcium_recommended: Float?
      let overall_calories_recommended: Float?
    let overall_protein_consumed: Float?
    let overall_carboHydrate_consumed : Float?
    let overall_fibre_consumed: Float?
     let overall_fat_consumed: Float?
    let overall_calories_consumed: Float?
    let overall_calcium_consumed: Float?
    
     var foodItems: [NutritionixFoodItems]?
     var macros: Macros?
    init(overall_protein_recommended: Float?,
         overall_carboHydrate_recommended: Float?,
          overall_fibre_recommended: Float?,
            overall_fat_recommended: Float?,
            overall_calcium_recommended : Float?,
            overall_calories_recommended: Float?,
            overall_protein_consumed: Float?,
            overall_carboHydrate_consumed:Float?,
            overall_fibre_consumed:Float?,
            overall_fat_consumed:Float?,
            overall_calcium_consumed:Float?,
            overall_calories_consumed:Float?,
            refId: Int?,
            time:String,
            actualQuantity:Int?)  {
        
        self.overall_protein_recommended = overall_protein_recommended
        self.overall_carboHydrate_recommended = overall_carboHydrate_recommended
        self.overall_fibre_recommended = overall_fibre_recommended
               self.overall_fat_recommended = overall_fat_recommended
               self.overall_calcium_recommended = overall_calcium_recommended
               self.overall_calories_recommended = overall_calories_recommended
         self.overall_protein_consumed = overall_protein_consumed
        self.overall_carboHydrate_consumed = overall_carboHydrate_consumed
        self.overall_fibre_consumed = overall_fibre_consumed
        self.overall_fat_consumed = overall_fat_consumed
        self.overall_calcium_consumed = overall_calcium_consumed
        self.overall_calories_consumed = overall_calories_consumed

    }
    init(from decoder: Decoder) throws {
        print("Snacks_1 exercises erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall_protein_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_protein_recommended)
        self.overall_carboHydrate_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_recommended)
        self.overall_fibre_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_recommended)
        self.overall_fat_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_fat_recommended)
        self.overall_calcium_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_recommended)
        self.overall_calories_recommended = try container.decodeIfPresent(Float.self, forKey: .overall_calories_recommended)
        self.overall_protein_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_protein_consumed)
        self.overall_carboHydrate_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_carboHydrate_consumed)
        self.overall_fibre_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fibre_consumed)
        self.overall_fat_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_fat_consumed)
        self.overall_calcium_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calcium_consumed)
        self.overall_calories_consumed = try container.decodeIfPresent(Float.self, forKey: .overall_calories_consumed)
        self.foodItems = try container.decodeIfPresent([NutritionixFoodItems].self, forKey: .foodItems)
        self.macros = try container.decodeIfPresent(Macros.self, forKey: .macros)
       
    }
}
extension Snacks{
    
    enum Snacks: String, CodingKey {
        case overall_protein_recommended
        case overall_carboHydrate_recommended
        case overall_fibre_recommended
        case overall_fat_recommended
        case overall_calcium_recommended
        case overall_calories_recommended
        case overall_protein_consumed
        case overall_carboHydrate_consumed
        case overall_fibre_consumed
        case overall_fat_consumed
        case overall_calories_consumed
        case overall_calcium_consumed
        case foodItems
        case macros
        
    }
}
// MARK: NUTRITIONIX FOODITEMS
struct NutritionixFoodItems: Codable {
    let foodId: Int?
    let catagory1: String?
    let catagory2: String?
    let foodCode: Int?
    let food_name: String?
    var totalFat: NutriInfo?
     var calcium: NutriInfo?
     var calories: NutriInfo?
    var nf_calories: NutriInfo?
    let serving_unit: String?
     var carboHydrate: NutriInfo?
     var protein: NutriInfo?
    var totalFibre: NutriInfo?
    let imgUrl: String?
    let foodStatus: String?
    var quantity: Quantity?
    let refId: Int?
    let time: String?
    let actualQuantity : Int?
    let consumedTime: String?
    let createdBy: String?
    var servingSize:Int?
    let units: String?
    var macros: Macros?
     var dailyValues:DailyValues?
    var photo: NutritionixPhoto?
    var serving_qty: NutriInfo?
    var serving_weight_grams: NutriInfo?
    var nf_total_carbohydrate: NutriInfo?
    var nf_total_fat: NutriInfo?
    var nf_dietary_fiber: NutriInfo?
    var nf_protein: NutriInfo?
    var alt_measures: [AlternateMeasures]?
    let nix_brand_id: String?
    let nix_brand_name: String?
    let nix_item_id:String?
    let nix_item_name:String?
}
//MARK: To parse Equipment
struct FoodItems: Codable {
    let foodId: Int
    let catagory1: String?
    let catagory2: String?
    let foodCode: Int
    let foodName: String?
    var totalFat: NutriInfo?
     var calcium: NutriInfo?
     var calories: NutriInfo?
     var carboHydrate: NutriInfo?
     var protein: NutriInfo?
    var totalFibre: NutriInfo?
    let imgUrl: String
    let foodStatus: String
    var quantity: Quantity?
    let refId: Int
       let time: String?
       let actualQuantity : Int?
    let consumedTime: String?
    
    let createdBy: String?
    var servingSize:Int
    let units: String
    var macros: Macros?
     var dailyValues:DailyValues?
    
    init(foodId: Int,
         catagory1: String?,
         catagory2: String?,
         foodCode: Int,
         foodName:String?,
         imgUrl:String,
         foodStatus:String,
         refId:Int,
         time: String?,
         actualQuantity : Int,
         createdBy: String?,
         servingSize:Int,
         units: String,
          consumedTime: String?)  {
        self.foodId = foodId
        self.catagory1 = catagory1
        self.catagory2 = catagory2
        self.foodCode = foodCode
        self.foodName = foodName
        self.imgUrl = imgUrl
         self.foodStatus = foodStatus
        self.refId = refId
               self.time = time
                self.actualQuantity = actualQuantity
        self.createdBy = createdBy
        self.servingSize = servingSize
         self.units = units
          self.consumedTime = consumedTime
    }
    init(from decoder: Decoder) throws {
        print("FoodItems erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.foodId = try container.decode(Int.self, forKey: .foodId)
        self.catagory1 = try container.decodeIfPresent(String.self, forKey: .catagory1)
         self.catagory2 = try container.decodeIfPresent(String.self, forKey: .catagory2)
          self.foodName = try container.decode(String.self, forKey: .foodName)
         self.imgUrl = try container.decode(String.self, forKey: .imgUrl)
        self.foodCode = try container.decode(Int.self, forKey: .foodCode)
         self.foodStatus = try container.decode(String.self, forKey: .foodStatus)
         self.quantity = try container.decode(Quantity.self, forKey: .quantity)
        
         self.totalFat = try container.decodeIfPresent(NutriInfo.self, forKey: .totalFat)
         self.calcium = try container.decodeIfPresent(NutriInfo.self, forKey: .calcium)
         self.calories = try container.decodeIfPresent(NutriInfo.self, forKey: .calories)
         self.carboHydrate = try container.decodeIfPresent(NutriInfo.self, forKey: .carboHydrate)
         self.protein = try container.decodeIfPresent(NutriInfo.self, forKey: .protein)
         self.totalFibre = try container.decodeIfPresent(NutriInfo.self, forKey: .totalFibre)
        self.actualQuantity = try container.decode(Int.self, forKey: .actualQuantity)
               self.refId = try container.decode(Int.self, forKey: .refId)
               self.time = try container.decodeIfPresent(String.self, forKey: .time)
         self.consumedTime = try container.decodeIfPresent(String.self, forKey: .consumedTime)
        
        self.createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy)
        self.servingSize = try container.decode(Int.self, forKey: .servingSize)
        self.units = try container.decode(String.self, forKey: .units)
         self.macros = try container.decodeIfPresent(Macros.self, forKey: .macros)
        self.dailyValues = try container.decodeIfPresent(DailyValues.self, forKey: .dailyValues)
    }
}
extension FoodItems {
    
    enum FoodItems: String, CodingKey {
        case foodId
        case catagory1
        case catagory2
        case foodCode
        case foodName
        case totalFat
        case calcium
        case calories
        case carboHydrate
        case protein
        case totalFibre
        case imgUrl
        case foodStatus
        case quantity
        case macros
         case dailyValues
        case consumedTime
        
    }
}
//MARK: Yo parse Comments
struct Type: Codable {
    let item_id: Int
    var item_text: String?
    
    init(item_id: Int,
         item_text: String?)  {
        self.item_id = item_id
        self.item_text = item_text
    }
    init(from decoder: Decoder) throws {
        print("Type erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.item_id = try container.decode(Int.self, forKey: .item_id)
        self.item_text = try container.decodeIfPresent(String.self, forKey: .item_text)
         
    }
}
struct Quantity: Codable {
    var recommended: Int
     var consumed: Int?
    
    init(recommended: Int,
         consumed : Int?)  {
        self.recommended = recommended
        self.consumed = consumed
    }
    init(from decoder: Decoder) throws {
        print("Quantity erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recommended = try container.decode(Int.self, forKey: .recommended)
        self.consumed = try container.decodeIfPresent(Int.self, forKey: .consumed)
         
    }
}

struct Macros: Codable {
    let carboHydrate_recommended: Int
     let protein_recommended: Int
    let fat_recommended:Int
    let carboHydrate_consumed: Int
    let  protein_consumed : Int
    let fat_consumed: Int
    
    init(carboHydrate_recommended: Int,
         protein_recommended : Int,
         fat_recommended: Int,
         protein_consumed : Int,
    carboHydrate_consumed: Int,
    fat_consumed : Int)  {
        self.carboHydrate_recommended = carboHydrate_recommended
        self.protein_recommended = protein_recommended
        self.fat_recommended = fat_recommended
        self.carboHydrate_consumed = carboHydrate_consumed
        self.fat_consumed = fat_consumed
        self.protein_consumed = protein_consumed
    }
    init(from decoder: Decoder) throws {
        print("Quantity erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.carboHydrate_recommended = try container.decode(Int.self, forKey: .carboHydrate_recommended)
        self.protein_recommended = try container.decode(Int.self, forKey: .protein_recommended)
        self.fat_recommended = try container.decode(Int.self, forKey: .fat_recommended)
        self.carboHydrate_consumed = try container.decode(Int.self, forKey: .carboHydrate_consumed)
        self.protein_consumed = try container.decode(Int.self, forKey: .protein_consumed)
        self.fat_consumed = try container.decode(Int.self, forKey: .fat_consumed)
         
    }
}
//
//{
//        "program_id":"5ef9cbcfc9dc072cde48ab8d",
//        "trainee_id":"d9b5beb0-61be-4ad0-8b0c-c752c16ad383",
//        "date":"21/07/2020",
//        "mealType":"lunch",
//        "consumedFoodItems":[{
//            "refId":1234,
//            "consumedQuantity":12,
//            "consumedTime":"6:00",
//            "status":"completed"
//        },
//        {
//           "refId":1234,
//            "consumedQuantity":12,
//            "consumedTime":"6:00",
//            "status":"completed"
//        }
//        ]
//}
struct WaterUpdatePostBoday: Codable {
   
    let date: String
   let trainee_id: String
    var waterConsumed: WaterConsumedPost?
    init(
         date:String,
        trainee_id: String)  {
      
        self.date = date
        self.trainee_id = trainee_id
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      //  self.program_id = try container.decode(String.self, forKey: .program_id)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
         self.waterConsumed = try container.decode(WaterConsumedPost.self, forKey: .waterConsumed)
    }
}
struct WaterConsumedPost: Codable {
    
   let consumed: Int
    let metric: String
}
struct WaterConsumed: Codable {
    
   let consumed: Int
    let lastUpdatedOn: String
    let metric: String
   
    init(consumed: Int,
         lastUpdatedOn: String,
         metric: String)  {
   
        self.consumed = consumed
         self.lastUpdatedOn = lastUpdatedOn
        self.metric = metric
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.consumed = try container.decode(Int.self, forKey: .consumed)
        self.lastUpdatedOn = try container.decode(String.self, forKey: .lastUpdatedOn)
        self.metric = try container.decode(String.self, forKey: .metric)
    }
}
struct MealUpdatePostBoday: Codable {
    let program_id: String
    let date: String
   let trainee_id: String
    let mealType: String
    var consumedFoodItems: [ConsumedFoodItems]?
    init(program_id: String,
         date:String,
         trainee_id: String,
         mealType: String,
         consumedFoodItems: [ConsumedFoodItems]?)  {
        self.program_id = program_id
        self.date = date
        self.trainee_id = trainee_id
        self.mealType = mealType
        self.consumedFoodItems = consumedFoodItems
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.mealType = try container.decode(String.self, forKey: .mealType)
         self.consumedFoodItems = try container.decode([ConsumedFoodItems].self, forKey: .consumedFoodItems)
    }
}
struct ConsumedFoodItems: Codable {
    let refId: Int
    let consumedQuantity: Double
   let consumedTime: String
    let foodStatus: String
   
    init(refId: Int,
         consumedQuantity:Double,
         consumedTime: String,
         foodStatus: String)  {
        self.refId = refId
        self.consumedQuantity = consumedQuantity
        self.consumedTime = consumedTime
         self.foodStatus = foodStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.refId = try container.decode(Int.self, forKey: .refId)
        self.consumedQuantity = try container.decode(Double.self, forKey: .consumedQuantity)
        self.consumedTime = try container.decode(String.self, forKey: .consumedTime)
        self.foodStatus = try container.decode(String.self, forKey: .foodStatus)
    }
}
struct AddFoodItems: Codable {
    let date: String
   let trainee_id: String
    let mealType: String
    let foodItem: Int
    init(date:String,
         trainee_id: String,
         mealType: String,
         foodItem: Int)  {
        self.date = date
        self.trainee_id = trainee_id
        self.mealType = mealType
        self.foodItem = foodItem
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.mealType = try container.decode(String.self, forKey: .mealType)
         self.foodItem = try container.decode(Int.self, forKey: .foodItem)
    }
}
struct DeleteFoodItems: Codable {
   // let program_id: String
    let date: String
   let trainee_id: String
    init(date:String,
         trainee_id: String)  {
        self.date = date
        self.trainee_id = trainee_id
       
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
       
    }
}
struct AddPostForCommonFood: Codable {
    let program_id: String
    let date: String
   let trainee_id: String
    init(program_id: String,
         date:String,
         trainee_id: String)  {
        self.program_id = program_id
        self.date = date
        self.trainee_id = trainee_id
       
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
       
    }
}
struct AddNutritionixFoodPostBody: Codable {
    let date: String
   let trainee_id: String
    let mealType: String
//   let foodStatus:String
//    let createdBy : String
//    let time:String

    var foodItem: NutritionixFoodData
    init(date:String,
         trainee_id: String,
         mealType: String,
         foodItem: NutritionixFoodData)  {
        self.date = date
        self.trainee_id = trainee_id
        self.mealType = mealType
        self.foodItem = foodItem
       
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.mealType = try container.decode(String.self, forKey: .mealType)
         self.foodItem = try container.decode(NutritionixFoodData.self, forKey: .foodItem)
    }
}
