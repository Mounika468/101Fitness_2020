//
//  DayWorkOuts.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 26/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct DayWorkOuts: Decodable {

    let day: Int
    var workouts: [Workouts]?
    var cardio : Cardio?
    let rest: Bool?
    init(day: Int,
         rest: Bool?)  {
                self.day = day
        self.rest = rest
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decode(Int.self, forKey: .day)
        self.workouts = try container.decodeIfPresent([Workouts].self, forKey: .workouts)
        self.cardio = try container.decodeIfPresent(Cardio.self, forKey: .cardio)
        self.rest = try container.decodeIfPresent(Bool.self, forKey: .rest)
    }
}
extension DayWorkOuts {
    
    enum CodingKeys: String, CodingKey {
        case day
        case workouts
        case cardio
        case rest
    }
}
//MARK: To parse Workouts
struct Workouts: Decodable {
    let workoutId: String
    let trainerId: String
    var workoutName: WorkoutName?
     var workoutExercises: [WorkoutExercises]?
    var workoutStatus: String?
    var workoutPercentage: String?
    var workoutComments : [Comments]?
    init(workoutId: String,
         trainerId: String,
         instructions: String,
         referenceId: Int,
         workoutStatus : String?,
         workoutPercentage: String?)  {
        self.workoutId = workoutId
        self.trainerId = trainerId
        self.workoutStatus = workoutStatus
        self.workoutPercentage = workoutPercentage
    }
    init(from decoder: Decoder) throws {
        print("workout erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.trainerId = try container.decode(String.self, forKey: .trainerId)
        self.workoutName = try container.decodeIfPresent(WorkoutName.self, forKey: .workoutName)
        self.workoutExercises = try container.decodeIfPresent([WorkoutExercises].self, forKey: .workoutExercises)
        self.workoutStatus = try container.decodeIfPresent(String.self, forKey: .workoutStatus)
        self.workoutPercentage = try container.decodeIfPresent(String.self, forKey: .workoutPercentage)
        self.workoutComments = try container.decodeIfPresent([Comments].self, forKey: .workoutComments)
    }
}
extension Workouts {
    
    enum CodingKeys: String, CodingKey {
        case workoutId
        case trainerId
        case workoutName
        case workoutExercises
        case workoutStatus
        case workoutPercentage
        case workoutComments
    }
}
//MARK: To parse Workouts Names
struct WorkoutName: Codable {
    let id: String
    let name: String
    let imgUrl: String?
    
    
    init(id: String,
         name: String,
         imgUrl: String?)  {
        
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        
    }
    init(from decoder: Decoder) throws {
        print("workoutname erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
    }
}
//MARK: To parse Workouts Exercises
struct WorkoutExercises: Codable {
    let exerciseId: String
    let exerciseName: String
    var sets: [Sets]?
    var exerciseVideo : ExerciseVideo?
      let instructions: String?
      let referenceId: Int?
      var exerciseStatus: String?
      var exercisePercentage: String?
    var exerciseComments: [Comments]?
    let restPeriodVal : Int?
    var equipment: OtherInfo?
     var level: OtherInfo?
    var force: OtherInfo?
    var mainMuscleWorkout: OtherInfo?
     var mechanicalType: OtherInfo?
     var otherMuscleWorkout: [OtherInfo]?
    init(exerciseId: String,
         exerciseName: String,
          instructions: String?,
            referenceId: Int?,
            exerciseStatus : String?,
            exercisePercentage: String?,
            restPeriodVal: Int?)  {
        
        self.exerciseId = exerciseId
        self.exerciseName = exerciseName
        self.instructions = instructions
               self.referenceId = referenceId
               self.exerciseStatus = exerciseStatus
               self.exercisePercentage = exercisePercentage
         self.restPeriodVal = restPeriodVal
        
    }
    init(from decoder: Decoder) throws {
        print("workout exercises erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.exerciseId = try container.decode(String.self, forKey: .exerciseId)
        self.exerciseName = try container.decode(String.self, forKey: .exerciseName)
        self.sets = try container.decodeIfPresent([Sets].self, forKey: .sets)
        self.exerciseVideo = try container.decodeIfPresent(ExerciseVideo.self, forKey: .exerciseVideo)
               self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
                self.referenceId = try container.decodeIfPresent(Int.self, forKey: .referenceId)
               self.exerciseStatus = try container.decodeIfPresent(String.self, forKey: .exerciseStatus)
                self.exercisePercentage = try container.decodeIfPresent(String.self, forKey: .exercisePercentage)
        self.restPeriodVal = try container.decodeIfPresent(Int.self, forKey: .restPeriodVal)
         self.exerciseComments = try container.decodeIfPresent([Comments].self, forKey: .exerciseComments)
        self.equipment = try container.decodeIfPresent(OtherInfo.self, forKey: .equipment)
        self.force = try container.decodeIfPresent(OtherInfo.self, forKey: .force)
        self.mainMuscleWorkout = try container.decodeIfPresent(OtherInfo.self, forKey: .mainMuscleWorkout)
        self.mechanicalType = try container.decodeIfPresent(OtherInfo.self, forKey: .mechanicalType)
        self.otherMuscleWorkout = try container.decodeIfPresent([OtherInfo].self, forKey: .otherMuscleWorkout)
        self.level = try container.decodeIfPresent(OtherInfo.self, forKey: .level)
    }
}
//MARK: To parse Equipment
struct OtherInfo: Codable {
    let id: String
    var name: String?
    let imgUrl: String?
    init(id: String,
         name: String?,
         imgUrl: String?)  {
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
    }
    init(from decoder: Decoder) throws {
        print("sets erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
         self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
    }
}
//MARK: Yo parse Comments
struct Comments: Codable {
    let commentId: String
    var commentDate: String?
     var comment: String?
    
    init(commentId: String,
         commentDate: String?,
         comment : String?)  {
        self.commentId = commentId
        self.commentDate = commentDate
        self.comment = comment
    }
    init(from decoder: Decoder) throws {
        print("sets erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.commentId = try container.decode(String.self, forKey: .commentId)
        self.commentDate = try container.decodeIfPresent(String.self, forKey: .commentDate)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
         
    }
}
struct PostComments: Codable {
    var commentDate: String?
     var comment: String?
    
    init(commentDate: String?,
         comment : String?)  {
        self.commentDate = commentDate
        self.comment = comment
    }
    init(from decoder: Decoder) throws {
        print("sets erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.commentDate = try container.decodeIfPresent(String.self, forKey: .commentDate)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
         
    }
}
//MARK: To parse Sets
struct Sets: Codable {
    let setNo: Int
    var reputationValue: DisplayVal?
     var restPeriod: DisplayVal?
    var maxWeights: DisplayVal?
    let heartrate : String?
     let restPeriodMetric : String?
      let weightsMetric : String?
    
    init(setNo: Int,
         weightsMetric: String?,
         restPeriodMetric : String?,
         heartrate : String?)  {
        self.setNo = setNo
        self.weightsMetric = weightsMetric
        self.restPeriodMetric = restPeriodMetric
        self.heartrate = heartrate
    }
    init(from decoder: Decoder) throws {
        print("sets erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.setNo = try container.decode(Int.self, forKey: .setNo)
        self.reputationValue = try container.decodeIfPresent(DisplayVal.self, forKey: .reputationValue)
        self.restPeriod = try container.decodeIfPresent(DisplayVal.self, forKey: .restPeriod)
         self.maxWeights = try container.decodeIfPresent(DisplayVal.self, forKey: .maxWeights)
         self.weightsMetric = try container.decodeIfPresent(String.self, forKey: .weightsMetric)
        self.restPeriodMetric = try container.decodeIfPresent(String.self, forKey: .restPeriodMetric)
         self.heartrate = try container.decodeIfPresent(String.self, forKey: .heartrate)
    }
}
//MARK: To parse Display Values
struct DisplayVal: Codable {
    let actual: Int
    var completed: Int?
    
    
    init(actual: Int,
         completed: Int?)  {
        
        self.actual = actual
        self.completed = completed
        
    }
    init(from decoder: Decoder) throws {
        print("display erroe")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.actual = try container.decode(Int.self, forKey: .actual)
        self.completed = try container.decodeIfPresent(Int.self, forKey: .completed)
    }
}
struct WOUpdatePostBody: Codable {
    let program_id: String
    let workoutId: String
    let date: String
   let exercise_referenceId: Int
 //  let week: String
   var sets: [Sets]?
   let trainee_id: String
   let exerciseStatus: String
    init(program_id: String,
         workoutId: String,
         date:String,
         exercise_referenceId: Int,
         trainee_id: String,
         exerciseStatus: String,
         sets: [Sets]?)  {
        
        self.program_id = program_id
        self.workoutId = workoutId
        self.date = date
        self.exercise_referenceId = exercise_referenceId
        self.trainee_id = trainee_id
        self.exerciseStatus = exerciseStatus
        self.sets = sets
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
         self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.date = try container.decode(String.self, forKey: .date)
        self.exercise_referenceId = try container.decode(Int.self, forKey: .exercise_referenceId)
        self.sets = try container.decode([Sets].self, forKey: .sets)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
         self.exerciseStatus = try container.decode(String.self, forKey: .exerciseStatus)
    }
}
struct CardioCommentsUpdatePostBody: Codable {
    let program_id: String
    let date: String
   var cardioComment: PostComments?
   let trainee_id: String
    let cardioStatus: String
    init(program_id: String,
         date:String,
         trainee_id: String,
         cardioComment: PostComments?,
         cardioStatus: String)  {
        self.program_id = program_id
        self.date = date
        self.trainee_id = trainee_id
        self.cardioComment = cardioComment
         self.cardioStatus = cardioStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.date = try container.decode(String.self, forKey: .date)
        self.cardioComment = try container.decode(PostComments.self, forKey: .cardioComment)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
         self.cardioStatus = try container.decode(String.self, forKey: .cardioStatus)
    }
}
struct ExercisesCommentsUpdatePostBody: Codable {
    let program_id: String
    let workoutId: String
    let exercise_referenceId: Int
    let date: String
   var exerciseComment: PostComments?
   let trainee_id: String
    let exerciseStatus: String
    init(program_id: String,
         workoutId: String,
         date:String,
         trainee_id: String,
         exerciseComment: PostComments?,
         exercise_referenceId: Int,
           exerciseStatus: String)  {
        self.program_id = program_id
        self.workoutId = workoutId
        self.date = date
        self.trainee_id = trainee_id
        self.exerciseComment = exerciseComment
        self.exercise_referenceId = exercise_referenceId
        self.exerciseStatus = exerciseStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
         self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.date = try container.decode(String.self, forKey: .date)
        self.exerciseComment = try container.decode(PostComments.self, forKey: .exerciseComment)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.exercise_referenceId = try container.decode(Int.self, forKey: .exercise_referenceId)
        self.exerciseStatus = try container.decode(String.self, forKey: .exerciseStatus)
    }
}
struct WOCommentsUpdatePostBody: Codable {
    let program_id: String
    let workoutId: String
    let date: String
   var workoutComment: PostComments?
   let trainee_id: String
     let workoutStatus: String
    init(program_id: String,
         workoutId: String,
         date:String,
         trainee_id: String,
         workoutComment: PostComments?,
          workoutStatus: String)  {
        self.program_id = program_id
        self.workoutId = workoutId
        self.date = date
        self.trainee_id = trainee_id
        self.workoutComment = workoutComment
         self.workoutStatus = workoutStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
         self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.date = try container.decode(String.self, forKey: .date)
        self.workoutComment = try container.decode(PostComments.self, forKey: .workoutComment)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
         self.workoutStatus = try container.decode(String.self, forKey: .workoutStatus)
    }
}
struct WOStatusUpdatePostBody: Codable {
    let program_id: String
    let workoutId: String
    let date: String
   let workoutStatus: String
   let trainee_id: String
    init(program_id: String,
         workoutId: String,
         date:String,
         trainee_id: String,
         workoutStatus: String)  {
        self.program_id = program_id
        self.workoutId = workoutId
        self.date = date
        self.trainee_id = trainee_id
        self.workoutStatus = workoutStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
         self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.date = try container.decode(String.self, forKey: .date)
        self.workoutStatus = try container.decode(String.self, forKey: .workoutStatus)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
    }
}
struct CardioStatusUpdatePostBody: Codable {
    let program_id: String
    let date: String
   let cardioStatus: String
   let trainee_id: String
    init(program_id: String,
         date:String,
         trainee_id: String,
         cardioStatus: String)  {
        self.program_id = program_id
        self.date = date
        self.trainee_id = trainee_id
        self.cardioStatus = cardioStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.cardioStatus = try container.decode(String.self, forKey: .cardioStatus)
    }
}
struct ExerciseStatusUpdatePostBody: Codable {
    let program_id: String
    let workoutId: String
    let date: String
   let exerciseStatus: String
   let trainee_id: String
     let exercise_referenceId: Int
    init(program_id: String,
         workoutId: String,
         date:String,
         trainee_id: String,
         exerciseStatus: String,
         exercise_referenceId: Int)  {
        self.program_id = program_id
        self.workoutId = workoutId
        self.date = date
        self.trainee_id = trainee_id
        self.exerciseStatus = exerciseStatus
        self.exercise_referenceId = exercise_referenceId
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
         self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.date = try container.decode(String.self, forKey: .date)
        self.exerciseStatus = try container.decode(String.self, forKey: .exerciseStatus)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
         self.exercise_referenceId = try container.decode(Int.self, forKey: .exercise_referenceId)
    }
}

struct CardioUpdatePostBoday: Codable {
    let program_id: String
    let date: String
   let trainee_id: String
    var cardioDistanceSet: DisplayVal?
    let cardioStatus: String
    init(program_id: String,
         date:String,
         trainee_id: String,
         cardioDistanceSet: DisplayVal?,
         cardioStatus:String)  {
        self.program_id = program_id
        self.date = date
        self.trainee_id = trainee_id
        self.cardioDistanceSet = cardioDistanceSet
         self.cardioStatus = cardioStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.program_id = try container.decode(String.self, forKey: .program_id)
        self.date = try container.decode(String.self, forKey: .date)
        self.trainee_id = try container.decode(String.self, forKey: .trainee_id)
        self.cardioDistanceSet = try container.decode(DisplayVal.self, forKey: .cardioDistanceSet)
         self.cardioStatus = try container.decode(String.self, forKey: .cardioStatus)
    }
}
