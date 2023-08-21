package pl.dmcs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Car;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.CarService;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
@Controller
public class addCarController {

    private final CarService carService;

    @Autowired
    public addCarController(CarService carService) {
        this.carService = carService;
    }

    @RequestMapping(value = "/addCar", method = RequestMethod.GET)
    public ModelAndView adicionarCarro() {
        return new ModelAndView("addCar", "Car", new Car());
    }



    @RequestMapping(value = "/addInfoCar", method = RequestMethod.POST)
    public String addCar(@ModelAttribute("Car") Car car) {
        System.out.println("CAR ADDED");
        System.out.println(car.getMake());

        carService.addCar(car);
        return "redirect:index";

    }
}

