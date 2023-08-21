package pl.dmcs.service;

import pl.dmcs.domain.CreditCard;

import java.util.List;

public interface CreditCardService {
    CreditCard saveCreditCard(CreditCard creditCard);



    CreditCard updateCreditCard(CreditCard creditCard);

    void deleteCreditCard(Long creditCardId);

    CreditCard getCreditCardById(Long creditCardId);
}