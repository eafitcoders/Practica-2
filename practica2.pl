vehiculo(toyota, rav4, suv, 28000, 2023).
vehiculo(toyota, corolla, sedan, 22000, 2022).
vehiculo(toyota, tundra, pickup, 35000, 2023).
vehiculo(toyota, supra, sport, 42000, 2022).
vehiculo(toyota, gr010, supersport, 1200000, 2024).
vehiculo(ford, explorer, suv, 31000, 2023).
vehiculo(ford, fusion, sedan, 24000, 2022).
vehiculo(ford, f150, pickup, 36000, 2023).
vehiculo(ford, mustang, sport, 45000, 2023).
vehiculo(ford, gt, supersport, 1000000, 2022).
vehiculo(bmw, x5, suv, 60000, 2023).
vehiculo(bmw, serie3, sedan, 41000, 2022).
vehiculo(bmw, m4, sport, 75000, 2023).
vehiculo(bmw, m8, supersport, 1300000, 2024).
vehiculo(bmw, x7, suv, 65000, 2024).

imprimir_vehiculos([H|T]) :-
    H = vehiculo(M,Mo,Ti,P,A),
    format('Marca: ~w | Modelo: ~w | Tipo: ~w | Precio: ~d | Anno: ~d~n', [M,Mo,Ti,P,A]),
    (T == [] -> true ; imprimir_vehiculos(T)).

datos :-
    write('Ingrese marca (toyota/ford/bmw): '), read(Marca),
    write('Ingrese tipo (suv/sedan/pickup/sport/supersport): '), read(Tipo),
    write('Ingrese presupuesto maximo: '), read(Presupuesto),
    (   findall(vehiculo(Marca,Modelo,Tipo,Precio,Ano),
        (vehiculo(Marca,Modelo,Tipo,Precio,Ano), Precio =< Presupuesto),
        Resultado),
        Resultado \= [] ->
            imprimir_vehiculos(Resultado)
    ;   write('No se encontraron vehiculos con esos criterios'), nl
    ).


filtrar_vehiculos(Marca, Tipo, Presupuesto, Resultado) :-
    findall(vehiculo(Marca, Modelo, Tipo, Precio, Ano),
        (
            vehiculo(Marca, Modelo, Tipo, Precio, Ano),
            Precio =< Presupuesto
        ),
        Resultado).

filtrar_por_categoria :-
    write('Categoria: '), read(Categoria),
    write('Precio max: '), read(PrecioMax),
    findall(vehiculo(M,Mo,C,P,A), (vehiculo(M,Mo,C,P,A), C == Categoria, P =< PrecioMax), R),
    imprimir_vehiculos(R).



% caso 1: findall(vehiculo(toyota,Mo,suv,P,_), (vehiculo(toyota,Mo,suv,P,_), P < 30000), R).
% caso 2: bagoff(vehiculo(ford,Mo,C,P,A), vehiculo(ford,Mo,C,P,A), R).
% total_sedan_value_under_limit(Total).
referencias_por_marca(Marca, L) :- findall(Mo, vehiculo(Marca,Mo,_,_,_), L).

sedan_prices(Prices) :-
    findall(Precio, (vehiculo(_, _, sedan, Precio, _), Precio =< 500000), Prices).

total_sedan_value_under_limit(Total) :-
    sedan_prices(Prices),
    sum_list(Prices, Total),
    Total =< 500000.
