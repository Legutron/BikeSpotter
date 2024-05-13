# BikeSpotter

## 👨 Author: Jakub Legut
 - [LinkedIn](https://www.linkedin.com/in/jakub-legut/)
 
## 👨 Comments

This project has been developed using MVVM architecture with UIKit and Async Await. In the future, it's worth considering adding in the future the following elements:
- Integration of translation handling, for example, using SwiftGen + Fastlane (POEditor)
- Asset management using SwifGen
- Implementation of a Coordinator pattern for navigation between views
- Utilization of Swift Package Manager (SPM) to modularize application features

**Disclaimer:**
1. The cell name is a combination of the station ID (without the city code) and the address. Unfortunately, the data is returned only in the format of the city code and a number (not as shown in the designs).
2. The native Apple Maps was utilized for this task since it was not specified which map should be used for implementation.
3. I added a red color indicator when there are 0 available bikes as a personal touch :)

Feel free to reach out if you have any questions or need further clarification. I'm available for assistance :)


## Zadanie rekrutacyjne
Zadanie polega na przygotowaniu małej aplikacji, która wyświetli na liście stacje rowerowe z Trójmiasta. Każda prezentowana stacja rowerowa powinna zawierać takie informacje jak:
- Nazwa stacji
- Ilość dostępnych rowerów i stanowisk dostępnych na stacji

Opcjonalnie: Możesz dodać obsługę lokalizacji użytkownika i wyświetlić dodatkowo:
- Odległość użytkownika od stacji

Kliknięcie w stacje otwiera widok szczegółów z pozycją stacji na mapie. Widoki powinny zostać zrealizowane z wykorzystaniem UIKit.

### Projekt graficzny aplikacji
[Link do projektu graficznego aplikacji](https://www.figma.com/file/Qnn3ZBn2I72zgk4DtquWxD/Zadanie-rekrutacyjne?type=design&node-id=0%3A1&mode=dev&t=E9djpPz3rjwiidCj-1)
Hasło: rekrutacja

### Dane
Dane (w formacie JSON) o dostępnych stacjach rowerowych w Trójmieście znajdują się pod linkami:
- [Informacje o stacjach rowerowych](https://gbfs.urbansharing.com/rowermevo.pl/station_information.json)
- [Status stacji rowerowych](https://gbfs.urbansharing.com/rowermevo.pl/station_status.json)

### GitHub
Projekt powinien być prowadzony i udostępniony przez GitHub (lub podobne serwisy). Pamiętaj, że rozwiązanie powinno przedstawiać skondensowaną próbkę Twoich umiejętności.


