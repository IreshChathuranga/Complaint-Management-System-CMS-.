package org.example.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDto {
    private String role;
    private String name;
    private String address;
    private int phone;
    private String email;
    private String password;
}
