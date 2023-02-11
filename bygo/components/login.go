package components

import (
	"github.com/gofiber/fiber/v2"

	_ "github.com/lib/pq"
)

type LoginInfo struct {
	ID  string `json:"login_id"`
	Pwd []byte `json:"login_password"`
}

func (l LoginInfo) isValid() error {

	// if err := bcrypt.CompareHashAndPassword(l.Pwd)
	return nil
}

// Check login
func PostLoginFunc(c *fiber.Ctx) error {
	// Get user data
	loginInfo := LoginInfo{}
	if err := c.BodyParser(&loginInfo); err != nil {
		return err
	}

	// Login id, password check
	if err := loginInfo.isValid(); err != nil {
		return err
	}

	// Generate JWT; Add Header

	return c.SendStatus(fiber.StatusOK)
}
