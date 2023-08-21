package pl.dmcs.domain;

import java.time.LocalDate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;


@Entity
@Table(name = "rentals")
public class Rental {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "car_id")
    private Car car;

    @ManyToOne
    @JoinColumn(name = "client_id")
    private AppUser client;

    @Column(name = "rental_date")
    private LocalDate rentalDate;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @NotNull
    @Column(name = "card_number")
    @Pattern(regexp = "^\\d{16}$", message = "Invalid card number format. Must be a 16-digit number.")
    private String cardNumber;

    @NotNull
    @Column(name = "expiration_date")
    @Pattern(regexp = "^(0[1-9]|1[0-2])\\/(\\d{2})$", message = "Invalid expiration date format. Must be in MM/YY format.")
    private String expirationDate;

    @NotNull
    @Column(name = "cvv")
    @Pattern(regexp = "^\\d{3}$", message = "Invalid CVV format. Must be a 3-digit number.")
    private String cvv;

    // Other fields, constructors, getters, and setters

    public Rental() {
        // Default constructor
    }

    public Rental(Car car, AppUser client, LocalDate rentalDate) {
        this.car = car;
        this.client = client;
        this.rentalDate = rentalDate;
    }

    public Rental(Car car, AppUser client, LocalDate rentalDate, LocalDate returnDate,String cardNumber,String expirationDate,String cvv) {
        this.car = car;
        this.client = client;
        this.rentalDate = rentalDate;
        this.returnDate = returnDate;
        this.cardNumber = cardNumber;
        this.expirationDate = expirationDate;
        this.cvv = cvv;
    }

    public AppUser getClient() {
        return client;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public void setClient(AppUser client) {
        this.client = client;
    }

    public LocalDate getRentalDate() {
        return rentalDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setRentalDate(LocalDate rentalDate) {
        this.rentalDate = rentalDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getCvv() {
        return cvv;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public Long getId() {
        return id;
    }

}
