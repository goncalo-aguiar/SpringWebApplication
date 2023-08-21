package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Car;
import pl.dmcs.domain.Rental;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.CarService;
import pl.dmcs.service.PdfService;
import pl.dmcs.service.RentalService;


import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.GrantedAuthority;
import java.util.Collection;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Controller
public class indexPageController {


    private final CarService carService;
    private final RentalService rentalService;
    private final AppUserService appUserService;

    private final PdfService pdfService;

    @Autowired
    public indexPageController(CarService carService, RentalService rentalService, AppUserService appUserService,PdfService pdfService) {
        this.carService = carService;
        this.rentalService = rentalService;
        this.appUserService = appUserService;
        this.pdfService = pdfService;
    }


    @RequestMapping("/index")
    public String getCars(Model model) {
        List<Car> cars = carService.getAllCars();
        model.addAttribute("cars", cars);
        Rental rental =  new Rental();
        model.addAttribute("rental", rental);

        // Access the authenticated user's authorities/roles
        Collection<? extends GrantedAuthority> authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("AQUI---->");
        System.out.println(username);
        // Get the rented cars for the user
        List<Rental> rentedCars = rentalService.getRentedCarsByUsername(username);

        // Add the rented cars to the model
        model.addAttribute("rentedCars", rentedCars);

        // Print the authorities/roles to check if "ADMIN" is present
        System.out.println("User Authorities/Roles: " + authorities);
        return "index";
    }




    @PostMapping("/deleteCar")
    public String rentCar(@RequestParam("carId") Long carId) {

        Optional<Car> rentedCar = carService.getCarById(carId);

        if (rentedCar.isPresent()) {
            carService.deleteAssociatedRentals(rentedCar.get());
            carService.deleteCar(carId);
        } else {
            System.out.println("NOT FOUND????");
        }

       return "redirect:index";
    }

    @PostMapping("/cancelRent")
    public String cancel(@RequestParam("rental") Long id) {

        Optional<Rental> rental = rentalService.getRentalById(id);

        if (rental.isPresent()) {
            rentalService.deleteRental(id);
        } else {
            System.out.println("NOT FOUND????");
        }

        return "redirect:index";
    }

    @PostMapping("/cancelRent1")
    public String cancel1(@RequestParam("rental") Long id) {

        Optional<Rental> rental = rentalService.getRentalById(id);

        if (rental.isPresent()) {
            rentalService.deleteRental(id);
        } else {
            System.out.println("NOT FOUND????");
        }

        return "redirect:seeRents";
    }

    @PostMapping("/generatePdf")
    public String pdf(@RequestParam("rental") Long id, HttpServletResponse response) {

        Optional<Rental> rental = rentalService.getRentalById(id);

        if (rental.isPresent()) {
            pdfService.generatePdf(rental.get(),response);
        } else {
            System.out.println("NOT FOUND????");
        }

        return "redirect:index";
    }


    @RequestMapping("/searchClient")
    public String search(Model model) {

        return "searchClient";
    }

}
