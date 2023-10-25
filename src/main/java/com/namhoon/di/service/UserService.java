package com.namhoon.di.service;

import com.namhoon.di.dto.UserDTO;
import com.namhoon.di.mapper.UserMapper;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class UserService {

    private final UserMapper userMapper;

    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public UserDTO getUserById(String id) {
        return userMapper.getUserById(id);
    }

    public void createUser(UserDTO user) {
        System.out.println("Service: Attempting to insert user: " + user.getId());

        // Ideally, hash the password before inserting
        // user.setPassword(bcryptEncoder.encode(user.getPassword()));

        userMapper.insertUser(user);
        System.out.println("Service: User insertion finished.");
    }

    public void updateUser(UserDTO user) {
        // Again, if updating the password, make sure to hash it
        userMapper.updateUser(user);
    }

    public void deleteUser(String id) {
        userMapper.deleteUser(id);
    }

    public boolean isDuplicatedId(String id) {
        UserDTO userDTO = userMapper.getUserById(id);
        return userDTO != null;
    }

    public boolean authenticate(UserDTO userDTO) {
        UserDTO storedUser = userMapper.getUserById(userDTO.getId());
        if (storedUser != null) {
            // You should compare hashed passwords here
            // return bcryptEncoder.matches(userDTO.getPassword(), storedUser.getPassword());
            return storedUser.getPassword().equals(userDTO.getPassword());
        }
        return false;
    }
}
