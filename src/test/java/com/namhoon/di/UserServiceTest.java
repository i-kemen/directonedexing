package com.namhoon.di;

import com.namhoon.di.dto.UserDTO;
import com.namhoon.di.mapper.UserMapper;
import com.namhoon.di.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.times;

@SpringBootTest
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @MockBean
    private UserMapper userMapper;

    @Test
    public void createUserTest() {
        UserDTO user = new UserDTO();
        user.setId("testId");
        user.setName("testName");
        user.setPassword("testPassword");
        user.setEmail("test@example.com");
        user.setPhoneNumber("1234567890");

        userService.createUser(user);

        verify(userMapper, times(1)).insertUser(user);
    }
}

