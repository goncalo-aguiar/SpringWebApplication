package pl.dmcs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.AppUserRole;
import pl.dmcs.repository.AppUserRepository;
import pl.dmcs.repository.AppUserRoleRepository;
import pl.dmcs.service.AppUserRoleService;
import pl.dmcs.service.AppUserService;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Controller
public class adminRolesController {

    @Autowired
    private AppUserService clientService; // Assuming you have a ClientService that retrieves the list of clients
    @Autowired
    private AppUserRoleService appUserRoleService; //

    @Autowired
    private AppUserRoleRepository appUserRoleRepository; //

    @Autowired
    private AppUserRepository appUserRepository; //
    @RequestMapping(value = "/seeClients")
    public String seeClients(Model model) {
        List<AppUser> clients = clientService.listAppUser(); // Fetch the list of clients from the service

        model.addAttribute("clients", clients); // Pass the clients to the view

        return "seeClients";
    }

    @ModelAttribute("availableRoles")
    public List<AppUserRole> getAvailableRoles() {
        // Retrieve the available roles from the database or any other source
        // You can replace this with your own logic to fetch the roles
        List<AppUserRole> roles = appUserRoleService.listAppUserRole();
        return roles;
    }
    @GetMapping("/assignRole/{clientId}/{role}")
    public String assignRole(@PathVariable Long clientId, @PathVariable String role) {
        // Perform the role assignment logic here
        System.out.println("Assigning role '" + role + "' to client with ID: " + clientId);

        // Find the client role by role name
        AppUserRole clientRole = appUserRoleRepository.findByRole(role);

        // Find the client by ID
        Optional<AppUser> user = appUserRepository.findById(clientId);

        // Check if the client and role exist
        if (user.isPresent() && clientRole != null) {
            AppUser client = user.get();
            Set<AppUserRole> x = client.getAppUserRole();
            x.add(clientRole);
            // Assign the role to the client
            client.setAppUserRole(x);
            appUserRepository.save(client);

            System.out.println("Role '" + role + "' assigned to client with ID: " + clientId);
        } else {
            // Handle case when client or role does not exist
            System.out.println("Client or role not found!");
        }

        // Redirect back to the client list page
        return "redirect:/seeClients";
    }
}
