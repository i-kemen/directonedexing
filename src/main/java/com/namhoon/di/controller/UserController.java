package com.namhoon.di.controller;

import com.namhoon.di.dto.UserDTO;
import com.namhoon.di.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginForm() {
        return "login"; // 로그인 페이지로 이동
    }

    @PostMapping("/loginProcess")
    public String loginProcess(UserDTO userDTO, Model model, HttpServletRequest request) {
        boolean isAuthenticated = userService.authenticate(userDTO);

        if (isAuthenticated) {
            // 사용자의 전체 정보를 데이터베이스에서 가져옵니다.
            UserDTO fullUserDTO = userService.getUserById(userDTO.getId());
            // 가져온 사용자 정보를 세션에 저장합니다.
            request.getSession().setAttribute("user", fullUserDTO);
            System.out.println("UserID stored in session: " + userDTO.getId());
            request.getSession().setAttribute("userId", userDTO.getId());
            return "redirect:/";
        } else {
            model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }
    }


    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate(); // 세션 무효화
        return "redirect:/"; // 메인 페이지로 리다이렉션
    }


    @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("userDTO", new UserDTO());
        return "signup";  // signup.html or signup.jsp 페이지로 이동
    }

    @PostMapping("/signup")
    public String signup(UserDTO userDTO, RedirectAttributes redirectAttributes) {
        try {
            userService.createUser(userDTO);
            redirectAttributes.addFlashAttribute("signupSuccess", true);
            redirectAttributes.addFlashAttribute("successMessage", "가입을 축하합니다.");
            return "redirect:/signupresult";  // 리다이렉트 방식으로 변경
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("signupSuccess", false);
            redirectAttributes.addFlashAttribute("errorMessage", "다시 가입해주세요.");
            return "redirect:/signup";
        }
    }

    @GetMapping("/signupresult")
    public String signupResult() {
        return "signupresult";
    }


    @GetMapping("/checkId")
    public ResponseEntity<String> checkId(@RequestParam String id) {
        boolean isDuplicated = userService.isDuplicatedId(id);
        if (isDuplicated) {
            return new ResponseEntity<>("duplicated", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("available", HttpStatus.OK);
        }
    }

}
