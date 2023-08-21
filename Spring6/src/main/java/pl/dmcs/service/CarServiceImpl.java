package pl.dmcs.service;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.domain.Car;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.Rental;
import pl.dmcs.repository.CarRepository;
import java.util.List;
import java.util.Optional;

@Service
public class CarServiceImpl implements CarService {
    private final CarRepository carRepository;
    private final RentalService rentalService;

    public CarServiceImpl(CarRepository carRepository,RentalService rentalService) {
        this.carRepository = carRepository;
        this.rentalService = rentalService;
    }

    @Transactional
    public Optional<Car> getCarById(Long carId) {
        return Optional.ofNullable(carRepository.findById(carId).orElseThrow(() -> new EntityNotFoundException("Car not found")));
    }


    @Transactional
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    @Transactional
    public void addCar(Car car) {
        carRepository.save(car);
    }

    @Transactional
    public void updateCar(Car car) {
        carRepository.save(car);
    }

    @Transactional
    public void deleteCar(Long carId) {
        Car car = carRepository.findById(carId).orElseThrow(() -> new EntityNotFoundException("Car not found"));
        carRepository.delete(car);
    }
    public void deleteAssociatedRentals(Car car) {
        List<Rental> rentals = rentalService.getRentalsByCar(car);
        for (Rental rental : rentals) {
            rentalService.deleteRental(rental.getId());
        }
    }

    // Other car-related methods
}
