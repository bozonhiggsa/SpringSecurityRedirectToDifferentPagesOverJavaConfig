package com.application.springSecurity.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller for requests handling
 * @author Ihor Savchenko
 * @version 1.0
 */
@Controller
public class MvcController {


    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public String index() {
        return "index";
    }

    @GetMapping(value= "/homepage.html")
    public String toHomepageForUser() {
        return "variousUsers";
    }

    @GetMapping(value= "/console.html")
    public String toConsoleForAdmin() {
        return "onlyAdmin";
    }

    @GetMapping(value= "/login.html")
    public String toLogin() {
        return "login";
    }


}
