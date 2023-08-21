package pl.dmcs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Rental;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.RentalService;

import java.util.List;

@Controller
public class seeRentsController {
    @Autowired
    private RentalService rentalService;
    @RequestMapping(value = "/seeRents")
    public String seeRents(Model model) {
        List<Rental> rentals = rentalService.getAllRentals();

        model.addAttribute("rentals", rentals); // Pass the clients to the view

        return "seeRents";
    }
}
