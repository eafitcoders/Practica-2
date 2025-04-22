vehicle(toyota, corolla, sedan, 22000, 2021).
vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(ford, ranger, pickup, 35000, 2021).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, m3, sport, 70000, 2022).
vehicle(chevrolet, equinox, suv, 26000, 2022).
vehicle(honda, civic, sedan, 21000, 2020).
vehicle(nissan, frontier, pickup, 30000, 2023).
vehicle(kia, soul, suv, 24000, 2023).

meet_budget(Reference, BudgetMax):-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.
vehicles_by_brand(Brand, Refs) :-
    findall(Ref, vehicle(Brand, Ref, _, _, _), Refs).
vehicles_grouped_by_brand(Brand,Grouped):-
    bagof((Type,Refs), bagof(Ref,Price^Year^(vehicle(Brand,Ref,Type,Price,Year)),Refs),Grouped).
sum_prices([], 0).
sum_prices([(_, Price)|T], Total) :-
    sum_prices(T, Rest),
    Total is Price + Rest.
generate_report(Brand, Type, Budget, Result) :-
    findall((Ref, Price),
        (vehicle(Brand, Ref, Type, Price, _), Price =< Budget),
        Vehicles),
    sum_prices(Vehicles, Total),
    Total =< 1000000,
    Result = Vehicles.
test_case1(Refs) :-
    findall(Ref, (vehicle(toyota, Ref, suv, Price, _), Price < 30000), Refs).
test_case2(Grouped) :-
    bagof((Type, Year, Ref), vehicle(ford, Ref, Type, _, Year), Grouped).

test_case3(Vehicles, Total) :-
    findall((Ref, Price), (vehicle(_, Ref, sedan, Price, _), Price =< 500000), Vehicles),
    sum_prices(Vehicles, Total),
    Total =< 500000.
