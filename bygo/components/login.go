package components

import (
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"

	_ "github.com/lib/pq"
)

type LoginInfo struct {
	UserID        int
	LoginID       string `json:"login_id"`
	LoginPassword string `json:"login_password"`
}

func (l *LoginInfo) isValid() error {
	// Get hashed password in DB by login_id
	var hashPassword []byte
	if err := DB.QueryRow(
		"SELECT id, login_password FROM USERS WHERE login_id = $1",
		l.LoginID,
	).Scan(
		&l.UserID,
		&hashPassword,
	); err != nil {
		return err
	}
	// Validation password
	if err := bcrypt.CompareHashAndPassword(hashPassword, []byte(l.LoginPassword)); err != nil {
		return err
	}
	return nil
}

// Check login
func PostLoginFunc(c *fiber.Ctx) error {
	// Get user data
	loginInfo := LoginInfo{}
	if err := c.BodyParser(&loginInfo); err != nil {
		return err
	}
	// Login_id, login_password check
	if err := loginInfo.isValid(); err != nil {
		return err
	}
	// Generate JWT; Add Header
	token, err := GenerateJWT(jwt.MapClaims{
		"exp":     time.Now().Add(VALID_DURATION).Unix(),
		"user_id": loginInfo.UserID,
	})
	if err != nil {
		return err
	}
	// Response 200, user_id for post todo
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"user_id": loginInfo.UserID,
		"jwt":     token,
	})
}
