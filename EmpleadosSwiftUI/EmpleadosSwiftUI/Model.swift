//
//  Model.swift
//  EmpleadosSwiftUI
//
//  Created by Dev1 on 13/09/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

var ctx:NSManagedObjectContext {
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

func saveContext() {
    if ctx.hasChanges {
        do {
            try ctx.save()
        } catch {
            print("Error en la carga \(error)")
        }
    }
}

struct EmpleadoJSON:Codable {
    let id:Int
    let first_name:String
    let last_name:String
    let email:String
    let avatar:URL
    let department:String
}

class DataLoading {
    
    func loadData() {
        guard let cargaURL = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json") else {
            return
        }
        do {
            let empleadosData = try Data(contentsOf: cargaURL)
//            if let datos = try JSONSerialization.jsonObject(with: empleadosData) as? [[String:Any]] {
//
//            }
            let datos = try JSONDecoder().decode([EmpleadoJSON].self, from: empleadosData)
            let cargaJSON = datos.map { return $0.dictionary }
            let countFetch:NSFetchRequest<Empleado> = Empleado.fetchRequest()
            let count = try ctx.count(for: countFetch)
            if count == 0 {
                let insertRequest = NSBatchInsertRequest(entity: Empleado.entity(), objects: cargaJSON)
                try ctx.execute(insertRequest)
                saveContext()
            } 
        } catch {
            print("Error en la carga \(error)")
        }
    }
}
