package pl.dmcs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Car;

@Repository
public interface CarRepository extends JpaRepository<Car, Long> {
    // Define car-related methods

}
