package pl.dmcs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Car;
import pl.dmcs.domain.Rental;

import java.util.List;


@Repository
public interface RentalRepository extends JpaRepository<Rental, Long> {
    List<Rental> findByCar(Car car);
    // Define car-related methods
    List<Rental> findByClient(AppUser USER);
}
