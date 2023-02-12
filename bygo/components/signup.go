package components

import (
	"github.com/gofiber/fiber/v2"
	"golang.org/x/crypto/bcrypt"
)

type SignUpInfo struct {
	LoginID       string `json:"login_id"`
	LoginPassword string `json:"login_password"`
}

// Save user data in DB
func (s SignUpInfo) SaveDB() error {
	// Make bcrypt password
	// Password must limit 72 bytes
	hashPassword, err := bcrypt.GenerateFromPassword([]byte(s.LoginPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	// Insert into DB
	if _, err := DB.Exec(
		"INSERT INTO USERS (login_id, login_password) VALUES ($1, $2)",
		s.LoginID,
		hashPassword,
	); err != nil {
		return err
	}
	return nil
}

// Sign up by user data
func PostSignUp(c *fiber.Ctx) error {
	// Get body
	loginInfo := SignUpInfo{}
	if err := c.BodyParser(&loginInfo); err != nil {
		return err
	}
	// Save on DB
	if err := loginInfo.SaveDB(); err != nil {
		return err
	}
	// Response 201
	return c.SendStatus(fiber.StatusCreated)
}
