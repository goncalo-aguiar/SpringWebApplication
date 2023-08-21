package pl.dmcs.controller;


import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Car;
import pl.dmcs.domain.CreditCard;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.CarService;
import pl.dmcs.service.CreditCardService;

@Controller
public class addCreditCardController {

    private final CreditCardService creditCardService;
    private final AppUserService appUserService;

    @Autowired
    public addCreditCardController(CreditCardService creditCardService,AppUserService appUserService) {
        this.creditCardService = creditCardService;
        this.appUserService = appUserService;
    }

    @RequestMapping(value = "/addCreditCard", method = RequestMethod.GET)
    public ModelAndView addCard(@RequestParam("userId") String userId, RedirectAttributes redirectAttributes) {
        ModelAndView modelAndView = new ModelAndView("addCreditCard");
        redirectAttributes.addAttribute("userId", userId);
        modelAndView.addObject("creditCard", new CreditCard());
        return modelAndView;
    }

    @RequestMapping(value = "/addInfoCreditCard", method = RequestMethod.POST)
    public String addCard(@ModelAttribute("creditCard") CreditCard creditCard,
                          @RequestParam("userId") String userId) {
        // Save the credit card information to the database or perform necessary actions

        AppUser utilizador = appUserService.findByLogin(userId);
        creditCard.setClient(utilizador);
        creditCardService.saveCreditCard(creditCard);

        // Access the userId directly from the method parameter
        System.out.println("AQQUIIIIII----->>>");
        System.out.println(userId);

        return "index";
    }

   /* @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public String submit(@RequestParam("file") MultipartFile file, ModelMap modelMap) {
        modelMap.addAttribute("file", file);
        return "fileUploadView";
    }*/

}