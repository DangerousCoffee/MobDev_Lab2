import Foundation

// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins

var group: String = ""
var student: String = ""
var studentGroupSplit: [String] = []

for studentGroupPair in studentsStr.components(separatedBy: "; ") { // split string into student - group pairs
	studentGroupSplit = studentGroupPair.components(separatedBy: " - ") // split pairs into arrays [student, group]
	group = studentGroupSplit[1]
	student = studentGroupSplit[0]

    if studentsGroups[group] == nil { // check for studentsGroups[group] to be empty, if empty we add array of current student, otherwise we append exisitng array with a new student
        studentsGroups[group] = [student]
    } else {
	    studentsGroups[group]?.append(student)
    }
}

for key in studentsGroups.keys {
    studentsGroups[key]?.sort()
}

// Your code ends

print(studentsGroups)
print()

// output: ["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"]]

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(Int.random(in: 0..<6)) { //replace arc4random_uniform(6) with Int.random(in 0..<6) because online compiler i used doesn't recognize the former function
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

for group in studentsGroups.keys {
	studentPoints[group] = [:] // create dict at studentPoints[group]
	
	for name in studentsGroups[group]! { // initialize array at studentPoints[group][name], unwrap value at studentsGroups[group]
		studentPoints[group]?[name] = [] // optional operator for studentPoints[group]
		
		for point in points { // add random value at studentPoints[group][name]
			studentPoints[group]?[name]?.append(randomValue(maxValue: point)) // optional chaining for studentPoints[group][name]
		}
	}
}

// Your code ends

print(studentPoints)
print()

// output ["ІВ-72": ["Киба Олег": [5, 8, 0, 12, 12, 12, 12, 9, 15], "Бортнік Василь": [0, 8, 12, 12, 12, 12, 9, 9, 0], "Тимко Андрій": [5, 8, 9, 12, 0, 9, 12, 12, 15], "Овчарова Юстіна": [0, 0, 0, 0, 11, 0, 12, 12, 14]], "ІВ-71": ["Гуменюк Олександр": [0, 8, 0, 12, 12, 0, 11, 9, 15], "Корнійчук Ольга": [5, 8, 9, 12, 9, 11, 9, 0, 15], "Музика Олександр": [5, 8, 12, 12, 11, 12, 11, 12, 0], "Трудов Антон": [0, 8, 12, 0, 12, 12, 11, 12, 14], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 9, 14], "Андрющенко Данило": [5, 0, 12, 0, 0, 11, 11, 11, 15]], "ІВ-73": ["Науменко Павло": [0, 8, 11, 12, 9, 0, 12, 12, 15], "Давиденко Костянтин": [4, 8, 12, 12, 9, 12, 12, 9, 15], "Капінус Артем": [5, 8, 12, 9, 11, 0, 0, 9, 11], "Гончар Юрій": [5, 6, 12, 9, 12, 0, 12, 12, 14], "Чередніченко Владислав": [4, 0, 11, 0, 11, 12, 12, 12, 15]]]

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

func sum(points: Array<Int>) -> Int { // function for finding sum of Ints in array
	var sum: Int = 0
	for point in points {
		sum += point
	}
	
	return sum
}

for group in studentsGroups.keys { // initialize dict at sumPoints[group]
	sumPoints[group] = [:]
	
	for name in studentsGroups[group]! { // initialize Int at sumPoints[group][name]
		sumPoints[group]?[name] = 0
		
		sumPoints[group]?[name]? = sum(points: studentPoints[group]![name]!) // apply function for every studentPoints[group][name]
	}
}


// Your code ends

print(sumPoints)
print()

// output ["ІВ-73": ["Науменко Павло": 97, "Гончар Юрій": 88, "Давиденко Костянтин": 75, "Чередніченко Владислав": 76, "Капінус Артем": 69], "ІВ-71": ["Андрющенко Данило": 65, "Музика Олександр": 87, "Феофанов Іван": 80, "Гуменюк Олександр": 95, "Трудов Антон": 69, "Корнійчук Ольга": 84], "ІВ-72": ["Киба Олег": 64, "Овчарова Юстіна": 57, "Бортнік Василь": 69, "Тимко Андрій": 63]]

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

func avg(groupPoints: Dictionary<String, Int>) -> Float { // function for finding average number of values in dict
	var average: Float = 0.0
	
	for name in groupPoints.keys {
		average += Float(groupPoints[name]!)
	}
	
	return average/Float(groupPoints.count)
}

var average: Float = 0.0

for group in studentsGroups.keys { // applying function to every dict in sumPoints
    average = avg(groupPoints: sumPoints[group]!)
	groupAvg[group] = average
}

// Your code ends

print(groupAvg)
print()

// output ["ІВ-72": 81.75, "ІВ-73": 74.4, "ІВ-71": 73.0]

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

for group in studentsGroups.keys {
	for name in studentsGroups[group]! { // going over names in studentsGroups[group]
		if sumPoints[group]![name]! > 60 { // check for condition for every name at sumPoints[group][name]
			if passedPerGroup[group] == nil { // check passedPerGroup[group] value for nil, add array of current name or append a name otherwise
				passedPerGroup[group] = [name]
			} else {
				passedPerGroup[group]?.append(name)
			}
		}
	}
}
			
// Your code ends

print(passedPerGroup)

// output ["ІВ-71": ["Андрющенко Данило": 98, "Гуменюк Олександр": 88, "Феофанов Іван": 75, "Трудов Антон": 69, "Корнійчук Ольга": 89, "Музика Олександр": 100], "ІВ-72": ["Киба Олег": 82, "Бортнік Василь": 92, "Тимко Андрій": 76, "Овчарова Юстіна": 93], "ІВ-73": ["Капінус Артем": 96, "Давиденко Костянтин": 68, "Чередніченко Владислав": 83, "Гончар Юрій": 58, "Науменко Павло": 70]]

// ["ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"]]


// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]
