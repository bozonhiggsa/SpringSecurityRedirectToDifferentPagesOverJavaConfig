package com.application.springSecurity.config;

import com.application.springSecurity.security.MySimpleUrlAuthenticationSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 * Java configuration of a Spring Security context
 * @author Ihor Savchenko
 * @version 1.0
 */
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    @Qualifier("authenticationSuccessHandler")
    AuthenticationSuccessHandler authenticationSuccessHandler;

    @Bean
    public UserDetailsService userDetailsService() {
        InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
        manager.createUser(User.withDefaultPasswordEncoder()
                .username("user").password("password").roles("USER").build());
        manager.createUser(User.withDefaultPasswordEncoder()
                .username("admin").password("admin").roles("ADMIN").build());
        return manager;
    }

    protected void configure(HttpSecurity http) throws Exception {

        http
                .authorizeRequests()
                .antMatchers("/").permitAll()
                .antMatchers("/login.html").permitAll()
                .antMatchers("/logout.html").permitAll()
                .antMatchers("/static/**").permitAll()
                .antMatchers("/**").authenticated()
                .and()
                .formLogin().loginPage("/login.html").loginProcessingUrl("/login.html")
                .successHandler(authenticationSuccessHandler)
                .and()
                .rememberMe().key("secretKey").tokenValiditySeconds(2419200)
                .and()
                .logout().logoutUrl("/logout.html").logoutSuccessUrl("/login.html?logout=true");
        http
                .requiresChannel()
                .antMatchers("/").requiresInsecure()
                .antMatchers("/**").requiresSecure();

    }

    @Bean("authenticationSuccessHandler")
    public AuthenticationSuccessHandler getAuthenticationSuccessHandler() {
        AuthenticationSuccessHandler authenticationSuccessHandler = new MySimpleUrlAuthenticationSuccessHandler();
        return authenticationSuccessHandler;
    }

}