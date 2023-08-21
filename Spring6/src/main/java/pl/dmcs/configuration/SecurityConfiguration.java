package pl.dmcs.configuration;

import jakarta.annotation.Resource;
import jakarta.servlet.DispatcherType;
import org.hibernate.jpa.boot.internal.PersistenceXmlParser;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfiguration {


    @Resource(name="myAppUserDetailsService")
    private UserDetailsService userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    DaoAuthenticationProvider authProvider(){
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        // for database users
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        // for in-memory users
        //authProvider.setUserDetailsService(userDetailsService());
        return authProvider;
    }

    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        UserDetails user = User.withDefaultPasswordEncoder()
                .username("user")
                .password("user")
                .roles("CLIENT")
                .build();
        UserDetails admin = User.withDefaultPasswordEncoder()
                .username("admin")
                .password("admin")
                .roles("ADMIN","MANAGER")
                .build();
        UserDetails student = User.withDefaultPasswordEncoder()
                .username("student")
                .password("student")
                .roles("STUDENT")
                .build();
        return new InMemoryUserDetailsManager(user, admin, student);
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // Other security configurations
                .headers()
                .frameOptions()
                .sameOrigin(); // or .disable() to completely disable frame options
        http
                .authorizeHttpRequests((authz) -> authz
                        .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                        /*.requestMatchers("/appUsers*").hasRole("ADMIN")
                        .requestMatchers("/exampleOne*").hasAuthority("ROLE_USER")
                        .requestMatchers("/exampleTwo*").hasAnyAuthority("ROLE_STUDENT", "ROLE_ADMIN")
                        .requestMatchers("/exampleThree*").hasRole("STUDENT")*/
                        .requestMatchers("/addCar*").hasAnyAuthority("ADMIN", "MANAGER")
                        .requestMatchers("/addCarInfo*").hasAnyAuthority("ADMIN", "MANAGER")
                        .requestMatchers("/seeClients*").hasAuthority("ADMIN")
                        .requestMatchers("/deleteCar*").hasAnyAuthority("ADMIN","MANAGER")
                        .requestMatchers("/helloPage*").permitAll()
                        .requestMatchers("/registerPage*").permitAll()
                        .requestMatchers("/addAppUser*").permitAll()
                        .requestMatchers("/login*").anonymous()

                        .anyRequest().authenticated()
                )
                // login with default login page
                //  .formLogin(form -> form
                //          .permitAll()
                //          )
                // login with custom login page
                .formLogin(form -> form
                        .loginPage("/login")
                        .usernameParameter("login")
                        .passwordParameter("password")
                        .failureUrl("/login?error")
                        .defaultSuccessUrl("/index",true) //use wisely
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/login?logout")
                )
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .accessDeniedHandler((request, response, accessDeniedException) -> {
                            // Print the error message to console
                            System.out.println("Access Denied: " + accessDeniedException.getMessage());
                            response.sendRedirect("/accessDenied");
                        })
                        .accessDeniedPage("/accessDenied")
                )
                .httpBasic();
        return http.build();
    }

}














