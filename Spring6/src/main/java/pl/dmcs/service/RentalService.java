package pl.dmcs.service;

import pl.dmcs.domain.Car;
import pl.dmcs.domain.Rental;

import java.util.List;
import java.util.Optional;

public interface RentalService {
    List<Rental> getAllRentals();

    Optional<Rental> getRentalById(Long id);

    Rental saveRental(Rental rental);

    void deleteRental(Long id);

    List<Rental> getRentalsByCar(Car car);

    List<Rental> getRentedCarsByUsername(String username);
}
