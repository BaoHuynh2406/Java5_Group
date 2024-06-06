package com.mts.toyskingdom.mapper;

import com.mts.toyskingdom.data.dto.UserRegistrationDto;
import com.mts.toyskingdom.data.entity.UserE;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@Mapper
public interface UserMapper {
public List<UserE> getAllUser();
public List<UserE> getUserByEmail(@Param("email") String email);
public List<UserE> getUserByidUser(@Param("idUser") int idUser);
public int insertUser(UserRegistrationDto UserRegistration);
public int updateUser(UserRegistrationDto UserRegistration);
public int deleteUser(@Param("idUser") int idUser);

}
