package com.namhoon.di.mapper;

import com.namhoon.di.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    // 사용자 ID로 사용자 정보를 가져오는 메서드
    UserDTO getUserById(@Param("id") String id);

    // 새로운 사용자 정보를 삽입하는 메서드
    void insertUser(UserDTO user);

    // 사용자 정보를 업데이트하는 메서드
    void updateUser(UserDTO user);

    // 사용자 ID로 사용자 정보를 삭제하는 메서드
    void deleteUser(@Param("id") String id);
}
