//
//  CoreDataManager.swift
//  Хочупомочь
//
//  Created by Булат on 04.07.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let coreDataQueue = DispatchQueue(label: "CoreDataQueue", qos: .background)
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext : NSManagedObjectContext = persistentContainer.viewContext
    
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
    
    func readingEventsToBundle(completion: @escaping ((Result<[Event], Error>) -> Void)) {
        
        coreDataQueue.sync {
            
            if let filepath = Bundle.main.path(forResource: "events", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    let jsonData = Data(contents.utf8)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Event].self, from: jsonData)
                    print(result)
                    
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                    
                    let fetchRequest: NSFetchRequest<Events> = Events.fetchRequest()
                    
                    let eventsCount = try viewContext.fetch(fetchRequest)
                    
                    print("eventsCount.count\(eventsCount.count)")
                    
                    if eventsCount.isEmpty {
                        
                        let event = Events(context: viewContext)
                        let event2 = Events(context: viewContext)
                        let event3 = Events(context: viewContext)
                        
                        event.adress = result[0].adress
                        event.des = result[0].description
                        event.desTwo = result[0].description2
                        event.footer = result[0].footer
                        event.imaageTwo = result[0].image2
                        event.fundName = result[0].fundName
                        event.imageThree = result[0].footer
                        event.mainImage = result[0].mainImage
                        event.id = Int16(result[0].id)
                        event.title = result[0].title
                        event.phone = result[0].phone
                        
                        event2.adress = result[1].adress
                        event2.des = result[1].description
                        event2.desTwo = result[1].description2
                        event2.footer = result[1].footer
                        event2.imaageTwo = result[1].image2
                        event2.fundName = result[1].fundName
                        event2.imageThree = result[1].footer
                        event2.mainImage = result[1].mainImage
                        event2.id = Int16(result[1].id)
                        event2.title = result[1].title
                        event2.phone = result[1].phone
                        
                        event3.adress = result[2].adress
                        event3.des = result[2].description
                        event3.desTwo = result[2].description2
                        event3.footer = result[2].footer
                        event3.imaageTwo = result[2].image2
                        event3.fundName = result[2].fundName
                        event3.imageThree = result[2].footer
                        event3.mainImage = result[2].mainImage
                        event3.id = Int16(result[2].id)
                        event3.title = result[2].title
                        event3.phone = result[2].phone
                        
                    }
                    
                    do {
                        try viewContext.save()
                        print("Метод try viewContext.save() сработал для Events")
                        
                    } catch let error {
                        print("Error \(error)")
                        print("Метод сохранения не сработал для Events")
                    }
                } catch {
                    print("contents could not be loaded")
                    completion(.failure(error))
                }
            } else {
                let error = NSError()
                print("example.txt not found!")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    var eventsObjectsArray : [EventEntity] = []
    var eventsEntityArray : [Events] = []
    func transformEventEntityToObject(completion: @escaping (Result<[EventEntity], Error>) -> Void){
        coreDataQueue.async { [self] in
            let fetchRequest: NSFetchRequest<Events> = Events.fetchRequest()
            do {
                let objects = try viewContext.fetch(fetchRequest)
                print("Размер массива Events - \(objects.count)")
                print("\(objects)")
                eventsEntityArray.append(contentsOf: objects)
                print("EVENTSARRAY\(eventsEntityArray)")
                eventsObjectsArray = eventsEntityArray.map { EventEntity(
                    des: $0.des,
                    title: $0.title,
                    id: $0.id,
                    footer: $0.footer,
                    fundName: $0.fundName,
                    adress: $0.adress,
                    phone: $0.phone,
                    des2: $0.desTwo,
                    mainImage: $0.mainImage,
                    image2: $0.imaageTwo,
                    image3: $0.imageThree,
                    category: $0.category)
                }
                print("Новый массив с типами \(eventsObjectsArray)")
                DispatchQueue.main.async {
                    completion(.success(eventsObjectsArray))
                }
            } catch let error {
                print("Error \(error)")
                print("Не удалось получить данные из Core Data")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func readingCategoryToBundle(completion: @escaping ((Result<[Category], Error>) -> Void)) {
        
        coreDataQueue.sync { [self] in
            print("146ё")
            if let filepath = Bundle.main.path(forResource: "category", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    print(contents + "Json считан")
                    let jsonData = Data(contents.utf8)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Category].self, from: jsonData)
                    print("Декодированный json")
                    print(result)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                    
                    let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
                    
                    let categoriesCount = try viewContext.fetch(fetchRequest)
                    
                    print("categoriesCount.count\(categoriesCount.count)")
                    
                    if categoriesCount.isEmpty {
                        
                        let category = Categories(context: self.viewContext)
                        let category2 = Categories(context: self.viewContext)
                        let category3 = Categories(context: self.viewContext)
                        let category4 = Categories(context: self.viewContext)
                        let category5 = Categories(context: self.viewContext)
                        
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
                        
                    }
                    do {
                        try self.viewContext.save()
                        print("Метод try viewContext.save() сработал")
                    } catch let error {
                        print("Error \(error)")
                        print("Метод сохранения не сработал")
                    }
                    //try? self.viewContext.save()
                } catch {
                    print("contents could not be loaded")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                print("example.txt not found!")
                let error = NSError()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            print("конец146ё")
        }
    }
    var newDataArray : [CategoryEntity] = []
    var dataArray : [Categories] = []
    
    func transformCategoryToObject(completion: @escaping ((Result<[CategoryEntity], Error>) -> Void)) {
        coreDataQueue.async { [self] in
            print("213ё")
            let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
            do {
                let objects = try viewContext.fetch(fetchRequest)
                print("Размер массива Categories - \(objects.count)")
                print("\(objects)")
                dataArray.append(contentsOf: objects)
                print("DADAARRAY\(dataArray)")
                newDataArray = dataArray.map { CategoryEntity(
                    id: $0.id,
                    name: $0.name,
                    image: $0.image,
                    events: $0.events
                ) }
                print("Новый массив с типами \(newDataArray)")
                DispatchQueue.main.async {
                    completion(.success(newDataArray))
                }
            } catch let error {
                print("Error \(error)")
                print("Не удалось получить данные из Core Data")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            print("конец213ё")
        }
    }
    
    func cleanCoreDataCategories() { // полностью чищу бд
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        if let result = try? viewContext.fetch(fetchRequest) {
            for object in result {
                viewContext.delete(object)
            }
            print("Размер массива Categories \(result.count)")
        }
        do {
            try viewContext.save()
        } catch {
            print("Ошибка сохраения контекста")
        }
    }
    
    func cleanCoreDataEvents() {
        let fetchRequest: NSFetchRequest<Events> = Events.fetchRequest()
        if let result = try? viewContext.fetch(fetchRequest) {
            for object in result {
                viewContext.delete(object)
            }
            print("Размер массива Events \(result.count)")
        }
        do {
            try viewContext.save()
        } catch {
            print("Ошибка сохраения контекста")
        }
    }    
}
