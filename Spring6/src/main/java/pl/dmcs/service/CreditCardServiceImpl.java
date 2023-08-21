package pl.dmcs.service;


import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.CreditCard;
import pl.dmcs.repository.CreditCardRepository;

@Service
public class CreditCardServiceImpl implements CreditCardService {

    private final CreditCardRepository creditCardRepository;

    public CreditCardServiceImpl(CreditCardRepository creditCardRepository) {
        this.creditCardRepository = creditCardRepository;
    }

    @Transactional
    public CreditCard saveCreditCard(CreditCard creditCard) {
        return creditCardRepository.save(creditCard);
    }

    @Transactional
    public CreditCard updateCreditCard(CreditCard creditCard) {
        return creditCardRepository.save(creditCard);
    }

    @Transactional
    public void deleteCreditCard(Long creditCardId) {
        creditCardRepository.deleteById(creditCardId);
    }

    @Transactional
    public CreditCard getCreditCardById(Long creditCardId) {
        return creditCardRepository.findById(creditCardId).orElse(null);
    }

}
