package pl.dmcs.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Car;
import pl.dmcs.domain.Rental;
import pl.dmcs.repository.AppUserRepository;
import pl.dmcs.repository.RentalRepository;

import java.util.List;
import java.util.Optional;

@Service
public class RentalServiceImpl implements RentalService {

    private final RentalRepository rentalRepository;
    private final AppUserRepository userRepository;

    @Autowired
    public RentalServiceImpl(RentalRepository rentalRepository,AppUserRepository userRepository) {
        this.rentalRepository = rentalRepository;
        this.userRepository = userRepository;
    }

    @Override
    public List<Rental> getAllRentals() {
        return rentalRepository.findAll();
    }

    @Override
    public Optional<Rental> getRentalById(Long id) {
        return rentalRepository.findById(id);
    }

    @Override
    public Rental saveRental(Rental rental) {
        return rentalRepository.save(rental);
    }

    @Override
    public void deleteRental(Long id) {
        rentalRepository.deleteById(id);
    }

    public List<Rental> getRentalsByCar(Car car) {

        return rentalRepository.findByCar(car);
    }

    public List<Rental> getRentedCarsByUsername(String username) {
        AppUser user = userRepository.findByLogin(username); // Assuming you have a UserRepository

        if (user == null) {
            throw new IllegalArgumentException("User not found: " + username);
        }

        return rentalRepository.findByClient(user); // Assuming you have a RentalRepository
    }
}
