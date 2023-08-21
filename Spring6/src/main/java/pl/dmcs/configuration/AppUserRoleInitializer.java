package pl.dmcs.configuration;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import pl.dmcs.domain.AppUserRole;
import pl.dmcs.repository.AppUserRoleRepository;

@Component
public class AppUserRoleInitializer {

    private final AppUserRoleRepository appUserRoleRepository;

    @Autowired
    public AppUserRoleInitializer(AppUserRoleRepository appUserRoleRepository) {
        this.appUserRoleRepository = appUserRoleRepository;
    }

    @PostConstruct
    public void initializeRoles() {
        String[] roles = {"ADMIN", "MANAGER", "CLIENT"};

        for (String roleName : roles) {
            if (!appUserRoleRepository.existsByRole(roleName)) {
                AppUserRole role = new AppUserRole();
                role.setRole(roleName);
                appUserRoleRepository.save(role);
            }
        }
    }
}