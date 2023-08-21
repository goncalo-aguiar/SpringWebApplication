package pl.dmcs.service;

import pl.dmcs.domain.Car;

import java.util.List;
import java.util.Optional;

public interface CarService {
    Optional<Car> getCarById(Long carId);

    List<Car> getAllCars();
    void addCar(Car car);
    void updateCar(Car car);
    void deleteCar(Long carId);
    // Other car-related methods

    void deleteAssociatedRentals(Car car);
}
