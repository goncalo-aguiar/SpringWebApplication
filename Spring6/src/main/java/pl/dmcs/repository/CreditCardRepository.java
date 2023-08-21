package pl.dmcs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.CreditCard;
import pl.dmcs.domain.Rental;

import java.util.List;

@Repository
public interface CreditCardRepository extends JpaRepository<CreditCard, Long> {
    // Define car-related methods
    List<CreditCard> findAllByClient(AppUser client);
}
