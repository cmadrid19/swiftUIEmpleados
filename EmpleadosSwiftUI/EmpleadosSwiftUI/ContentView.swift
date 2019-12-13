//
//  ContentView.swift
//  EmpleadosSwiftUI
//
//  Created by Dev1 on 13/09/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import SwiftUI
import CoreData

struct FilaEmpleado: View {
    let empleado:Empleado
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(empleado.last_name ?? ""),\(empleado.first_name ?? "") ")
                    .font(.body)
                Text(empleado.email ?? "")
                    .font(.footnote)
            }
            .fixedSize()
            Spacer()
            Image(systemName: "person.fill")
        }
    }
}

struct ContentView: View {
    @FetchRequest(entity: Empleado.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(Empleado.id), ascending: true)])
    var empleadoDB:FetchedResults<Empleado>
    
    var body: some View {
        NavigationView {
            List(empleadoDB, id: \.self) { empleado in
                FilaEmpleado(empleado: empleado)
            }
            .navigationBarTitle(Text("Empleados"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
