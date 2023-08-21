package pl.dmcs.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.AppUserRole;
import pl.dmcs.repository.AppUserRoleRepository;
import pl.dmcs.service.AppUserService;
import pl.dmcs.service.EmailService;
import pl.dmcs.service.ReCaptchaService;


@Controller
public class RegisterController {

    private AppUserService appUserService;
    private AppUserRoleRepository appUserRoleRepository;

    private EmailService emailService;

    @Autowired
    public RegisterController(AppUserService appUserService, AppUserRoleRepository appUserRoleRepository,EmailService emailService) {
        this.appUserService = appUserService;
        this.appUserRoleRepository = appUserRoleRepository;
        this.emailService = emailService;
    }

    // injecte by method
    ReCaptchaService reCaptchaService;

    @Autowired
    public void setReCaptchaService(ReCaptchaService reCaptchaService) {
        this.reCaptchaService = reCaptchaService;
    }

    @RequestMapping(value = "/registerPage")
    public ModelAndView showAppUsers() {

	 /*  AppUser appUser = new AppUser();
	   appUser.setFirstName("rafal");
	   appUser.setLastName("kotas");
	   appUser.setEmail("rkotas@dmcs.pl");
	   appUser.setTelephone("123456789");*/

        return new ModelAndView("register", "AppUser", new AppUser());
    }

    @PostMapping("/addAppUser")
    public ModelAndView addAppUser(@ModelAttribute("AppUser") @Valid AppUser appUser, BindingResult bindingResult, HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();

        if (bindingResult.hasErrors()) {
            modelAndView.setViewName("register");
            return modelAndView;
        }

        try {
            if (appUserService.findByLogin(appUser.getLogin()) != null) {
                bindingResult.rejectValue("login", "error.exists", "Username already exists");
                modelAndView.setViewName("register");
                return modelAndView;
            }
            if (reCaptchaService.verify(request.getParameter("g-recaptcha-response"))){
                System.out.println("First Name: " + appUser.getFirstName() +
                        " Last Name: " + appUser.getLastName() + " Tel.: " +
                        appUser.getTelephone() + " Email: " + appUser.getEmail());

                AppUserRole clientRole = appUserRoleRepository.findByRole("CLIENT");
                appUser.getAppUserRole().add(clientRole);

                appUserService.addAppUser(appUser);
                String send = "Thank you for registering in our Rent a Car app!";
                emailService.sendMail(appUser.getEmail(),send,"Register Confirmation");
                modelAndView.setViewName("redirect:login");
            }
            else{
                modelAndView.setViewName("register");
                return modelAndView;
            }
        } catch (DataIntegrityViolationException ex) {
            bindingResult.rejectValue("login", "error.exists", "Username already exists");
            modelAndView.addObject("errorMessage", "Username already exists");
            modelAndView.setViewName("register");
            return modelAndView;
        }
        return modelAndView;
    }

}

