package org.example.repository;

import org.example.model.User;

import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;

public class UserRepository {

    private static List<User> users = List.of(
            new User("habibbouzo21@gmail.com", "123456", "Habib Bouzoffara"),
            new User("test.test@gmail.com", "123456", "test"),
            new User("1","1","habib"));

    public UserRepository() {
    }

    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        Predicate<User> matchCredentials = user -> user.getEmail().equals(email) && user.getPassword().equals(pwd);
        return users.stream().filter(matchCredentials).findFirst();

    }
}
