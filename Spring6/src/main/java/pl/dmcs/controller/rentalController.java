package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import pl.dmcs.domain.*;
import pl.dmcs.repository.CreditCardRepository;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.CarService;
import pl.dmcs.service.CreditCardService;
import pl.dmcs.service.RentalService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.Set;


@Controller
public class rentalController {

    private final CarService carService;
    private final RentalService rentalService;
    private final AppUserService appUserService;

    private final CreditCardRepository creditCardRepository;

    private final CreditCardService creditCardService;

    @Autowired
    public rentalController(CarService carService, RentalService rentalService, AppUserService appUserService,CreditCardRepository creditCardRepository,CreditCardService creditCardService) {
        this.carService = carService;
        this.rentalService = rentalService;
        this.appUserService = appUserService;
        this.creditCardRepository = creditCardRepository;
        this.creditCardService = creditCardService;
    }

   /* @PostMapping("/rent")
    public String rentCar(HttpServletRequest request, Model model) {
        String carId = request.getParameter("carId");
        String userId = request.getParameter("userId");
        Car car = carService.getCarById(Long.valueOf(carId)).orElse(null);
        System.out.println("IM HERE");
        if (car != null && car.isAvailable()) {
            // Retrieve the logged-in user
            AppUser loggedInUser = appUserService.findByLogin(userId);

            // Perform the rental operation
            car.setAvailable(false);
            carService.updateCar(car);
            Rental rental =  new Rental(car,loggedInUser,LocalDate.now());
            rentalService.saveRental(rental);

            // Optionally, you can pass any rental-related information to the view
            model.addAttribute("rentalSuccessMessage", "Car rented successfully!");
        } else {
            // Handle the case where the car is not available or not found
            model.addAttribute("rentalErrorMessage", "Car not available for rent.");
        }

        // Redirect to the index page or any other appropriate page
        return "index";
        // Perform necessary operations with carId and userId

    }*/

    @PostMapping("/rent")
    public String rentCar(@RequestParam("carId") Long carId,
                          @RequestParam("userId") String userId,
                          RedirectAttributes attributes) {
        // Retrieve the rented car based on the carId
        Optional<Car> rentedCar = carService.getCarById(carId);

        // Check if the rentedCar is present
        if (rentedCar.isPresent()) {
            Car car = rentedCar.get();
            // Perform necessary operations with the rented car
            System.out.println(car.getId());
            System.out.println(car.getMake());
            // ...

            // Pass the rented car information to the next page as flash attributes
            attributes.addFlashAttribute("rentedCar", car);
            attributes.addFlashAttribute("userId", userId);
        } else {
            // Handle the case when the rented car is not found
            // ...
            System.out.println("NOT FOUND????");
        }

        // Redirect to the next page while preserving the selected rented car's information
        return "redirect:/rentCar";
    }

    @GetMapping("/rentCar")
    public String rentedCarPage(@ModelAttribute("rentedCar") Car rentedCar,
                                @ModelAttribute("userId") String userId,Model model) {
        // Perform necessary operations with the rented car
        System.out.println("ENTREI AQUI");
        AppUser utili = appUserService.findByLogin(userId);
        List<CreditCard> userCreditCards = creditCardRepository.findAllByClient(utili);

        if (rentedCar != null) {
            System.out.println(rentedCar.getId());
            System.out.println(rentedCar.getMake());
            // ...
        }
        model.addAttribute("userCreditCards", userCreditCards);
        return "rentCar"; // Return the name of the view page
    }

    @PostMapping("/processRental")
    public String processRental(@Valid @ModelAttribute("rental") Rental rental,
                                BindingResult bindingResult,
                                @RequestParam("startDate") String startDate,
                                @RequestParam("endDate") String endDate,
                                @RequestParam("rentedCar") Long rentedCarId,
                                @RequestParam("userId") String userId,
                                Model model) {
        Optional<Car> savedCar1 = carService.getCarById(rentedCarId);
        List<Rental> existingRentals = rentalService.getAllRentals();
        LocalDate localDate11 = LocalDate.parse(startDate);
        LocalDate localDate22 = LocalDate.parse(endDate);
        boolean isCarAvailable = true;
        if (savedCar1.isPresent()) {
            for (Rental aux : existingRentals) {
                if (aux.getCar().getId().equals(savedCar1.get().getId())) {
                    LocalDate rentalDate = aux.getRentalDate();
                    LocalDate returnDate = aux.getReturnDate();
                    if ((rentalDate.isBefore(localDate11) || rentalDate.isEqual(localDate11))
                            && (returnDate.isAfter(localDate22) || returnDate.isEqual(localDate22))) {
                        isCarAvailable = false;
                        break;
                    }
                }
            }
        }

        if (!isCarAvailable) {
            String errorMessage = "The car is already rented during the requested dates. Please choose different dates or pick another car.";
            System.out.println("DEU ERRO");
            bindingResult.rejectValue("rentalDate", "error.rental", errorMessage);
        }
        // Check for validation errors
        if (bindingResult.hasErrors()) {
            // Retrieve the rented car based on the carId
            Optional<Car> rentedCar = carService.getCarById(rentedCarId);

            if (rentedCar.isPresent()) {
                model.addAttribute("rentedCar", rentedCar.get());
                model.addAttribute("userId", userId);
            } else {
                System.out.println("Problem!");
            }

            // Set the error attributes with the error messages
            if (bindingResult.hasFieldErrors("cardNumber")) {
                model.addAttribute("cardNumberError", bindingResult.getFieldError("cardNumber").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("expirationDate")) {
                model.addAttribute("expirationDateError", bindingResult.getFieldError("expirationDate").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("cvv")) {
                model.addAttribute("cvvError", bindingResult.getFieldError("cvv").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("rentalDate")) {
                model.addAttribute("startDateError", bindingResult.getFieldError("rentalDate").getDefaultMessage());
            }

            // Return to the form with the validation errors
            return "rentCar";
        }

        // Perform necessary operations with the rental dates and additional information
        System.out.println("Start Date: " + startDate);
        System.out.println("End Date: " + endDate);
        System.out.println("Card Number: " + rental.getCardNumber());
        System.out.println("Expiration Date: " + rental.getExpirationDate());
        System.out.println("CVV: " + rental.getCvv());

        // ...

        // Pass the rental dates and additional information to the confirmation page
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("cardNumber", rental.getCardNumber());
        model.addAttribute("expirationDate", rental.getExpirationDate());
        model.addAttribute("cvv", rental.getCvv());

        // Convert String to LocalDate if needed
        LocalDate localDate1 = LocalDate.parse(startDate);
        LocalDate localDate2 = LocalDate.parse(endDate);

        Optional<Car> savedCar = carService.getCarById(rentedCarId);

        if (savedCar.isPresent()) {

            Rental newRental = new Rental(savedCar.get(), appUserService.findByLogin(userId), localDate1, localDate2, rental.getCardNumber(), rental.getExpirationDate(), rental.getCvv());
            rentalService.saveRental(newRental);
        } else {
            System.out.println("Problem!");
        }

        return "redirect:index"; // Redirect to the confirmation page
    }




}


