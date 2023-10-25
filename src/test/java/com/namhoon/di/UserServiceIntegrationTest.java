package com.namhoon.di;


import com.namhoon.di.dto.UserDTO;
import com.namhoon.di.service.UserService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class UserServiceIntegrationTest {

    @Autowired
    private UserService userService;

    @BeforeEach
    public void setUp() {
        // 데이터베이스 초기화 코드 (옵션)
    }

    @AfterEach
    public void tearDown() {
        // 테스트 후 정리 코드 (옵션)
    }

    @Test
    public void createUserTest() {
        UserDTO user = new UserDTO();
        user.setId("testId");
        user.setName("testName");
        user.setPassword("testPassword");
        user.setEmail("test@example.com");
        user.setPhoneNumber("1234567890");

        userService.createUser(user);

        UserDTO savedUser = userService.getUserById("testId");
        assertNotNull(savedUser);
        assertEquals("testName", savedUser.getName());
    }
}
