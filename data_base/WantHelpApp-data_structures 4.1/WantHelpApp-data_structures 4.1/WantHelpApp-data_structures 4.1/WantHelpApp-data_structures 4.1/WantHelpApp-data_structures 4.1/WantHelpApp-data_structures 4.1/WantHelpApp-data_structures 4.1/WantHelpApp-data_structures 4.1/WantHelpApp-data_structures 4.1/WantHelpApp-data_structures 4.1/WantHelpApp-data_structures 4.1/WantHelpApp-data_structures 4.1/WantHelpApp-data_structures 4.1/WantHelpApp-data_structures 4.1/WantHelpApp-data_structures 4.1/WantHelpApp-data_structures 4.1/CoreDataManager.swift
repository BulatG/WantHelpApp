//
//  CoreDataManager.swift
//  Хочупомочь
//
//  Created by Булат on 04.07.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Core Data stack Инициализация стека Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in /// loadPersistentStores Дает указание постоянному контейнеру загрузить постоянные хранилища.
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext : NSManagedObjectContext = persistentContainer.viewContext/// контекст
    //lazy var viewContextForEvent : NSManagedObjectContext = persistentContainer.viewContext///контекст для событий
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func takeEvent() {
        let event = Events(context: viewContext)
        
        if let filepath = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = Data(contents.utf8)
                let decoder = JSONDecoder()
                let result = try decoder.decode([Event].self, from: jsonData)
                print(result)
        
        event.adress = result[0].adress
        event.des = result[0].description
        event.des2 = result[0].description2
        event.fundName = result[0].fundName
        event.phone = result[0].phone
        event.footer = result[0].footer
        event.id = Int16(result[0].id)
        event.mainImage = result[0].mainImage
        event.image2 = result[0].image2
        event.image3 = result[0].image3
                
                do {
                    try viewContext.save()
                    print("Метод try viewContext.save() сработал")
                } catch let error {
                    print("Error \(error)")
                    print("Метод сохранения не сработал")
                }
                
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("example.txt not found!")
        }
    }
    
    func readingCategoryToBundle() -> [Categories] { // считывание в бандл и сохранение в бд
        let category = Categories(context: viewContext)
        let category2 = Categories(context: viewContext)
        let category3 = Categories(context: viewContext)
        let category4 = Categories(context: viewContext)
        let category5 = Categories(context: viewContext)
        
        
        
        if let filepath = Bundle.main.path(forResource: "category", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents + "Json считан")
                let jsonData = Data(contents.utf8)
                let decoder = JSONDecoder()
                let result = try decoder.decode([Category].self, from: jsonData)
                print("Декодированный json")
                print(result)
                
                category.name = result[0].name
                category.id = Int16(result[0].id)
                category.image = result[0].image
                
                category2.name = result[1].name
                category2.image = result[1].image
                category2.id = Int16(result[1].id)
                
                category3.name = result[2].name
                category3.image = result[2].image
                category3.id = Int16(result[2].id)
                
                category4.name = result[3].name
                category4.image = result[3].image
                category4.id = Int16(result[3].id)
                
                category5.name = result[4].name
                category5.image = result[4].image
                category5.id = Int16(result[4].id)
                
                
                do {
                    try viewContext.save()
                    print("Метод try viewContext.save() сработал")
                } catch let error {
                    print("Error \(error)")
                    print("Метод сохранения не сработал")
                }
                
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("example.txt not found!")
        }
        return [category]
    }
    var newDataArray : [CategoryEntity] = []
    var dataArray : [Categories] = []
    func transform() -> [CategoryEntity] { // запрос в бд за массивом сущностей и маппинг в новый массив
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        do {
            let objects = try viewContext.fetch(fetchRequest)
            print("Размер массива Categories - \(objects.count)")
            print("\(objects)")
            dataArray.append(contentsOf: objects)// после запроса в бд добавляем сущности в массив
            print("DADAARRAY\(dataArray)")
            newDataArray = dataArray.map { CategoryEntity( // маппим массив Categories в CategotyEntity
                id: $0.id,
                name: $0.name,
                image: $0.image,
                events: $0.events
            ) }
            print("Новый массив с типами \(newDataArray)")
        } catch let error {
            print("Error \(error)")
            print("Не удалось получить данные из Core Data")
        }
        return newDataArray
    }
    
    func cleanCoreDataAllCategories() { // полностью чищу бд
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        if let result = try? viewContext.fetch(fetchRequest) {
            for object in result {
                viewContext.delete(object)
            }
        }
        do {
            try viewContext.save() // <- remember to put this :)
        } catch {
            print("Ошибка сохраения контекста")
        }
    }
    
    func readingEventsToBundle() {
        //let event = Events(context: viewContext)
        
        //        let event2 = Events(context: viewContext)
        //        let event3 = Events(context: viewContext)
        
        if let filepath = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = Data(contents.utf8)
                let decoder = JSONDecoder()
                let result = try decoder.decode([Event].self, from: jsonData)
                print(result)
                
                //                event.adress = result[0].adress
                //                event.des = result[0].description
                //                event.des2 = result[0].description2
                //                event.fundName = result[0].fundName
                //                event.phone = result[0].phone
                //                event.footer = result[0].footer
                //                event.id = Int16(result[0].id)
                //                event.mainImage = result[0].mainImage
                //                event.image2 = result[0].image2
                //                event.image3 = result[0].image3
                
                //                event2.adress = result[1].adress
                //                event2.des = result[1].description
                //                event2.des2 = result[1].description2
                //                event2.fundName = result[1].fundName
                //                event2.phone = result[1].phone
                //                event2.footer = result[1].footer
                //                event2.id = Int16(result[1].id)
                //                event2.mainImage = result[1].mainImage
                //                event2.image2 = result[1].image2
                //                event2.image3 = result[1].image3
                //
                //                event3.adress = result[2].adress
                //                event3.des = result[2].description
                //                event3.des2 = result[2].description2
                //                event3.fundName = result[2].fundName
                //                event3.phone = result[2].phone
                //                event3.footer = result[2].footer
                //                event3.id = Int16(result[2].id)
                //                event3.mainImage = result[2].mainImage
                //                event3.image2 = result[2].image2
                //                event3.image3 = result[2].image3
                
                do {
                    try viewContext.save()
                    print("Метод try viewContext.save() сработал для Events")
                } catch let error {
                    print("Error \(error)")
                    print("Метод сохранения не сработал для Events это пиздец")
                }
                
            } catch let error{
                print("Error + \(error)")
            }
        } else {
            print("Файл events.json не найден")
        }
    }
}
