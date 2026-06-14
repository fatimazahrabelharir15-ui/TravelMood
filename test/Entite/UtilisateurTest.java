package Entite;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class UtilisateurTest {

    @Test
    public void testConstructeurUtilisateur() {

        Utilisateur u = new Utilisateur(
                1,
                "Malak",
                "Ech-chaji",
                "malak@gmail.com",
                "0612345678",
                "password123",
                "client"
        );

        assertEquals(1, u.getId());
        assertEquals("Malak", u.getNom());
        assertEquals("Ech-chaji", u.getPrenom());
        assertEquals("malak@gmail.com", u.getEmail());
        assertEquals("0612345678", u.getTelephone());
        assertEquals("password123", u.getMotpass());
        assertEquals("client", u.getRole());
    }
}