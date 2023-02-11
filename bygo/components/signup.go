package components

import "github.com/gofiber/fiber/v2"

type SignUpInfo struct {
	LoginID       string `json:"login_id"`
	LoginPassword string `json:"login_password"`
}

func (s SignUpInfo) SaveDB() error {

	return nil
}

// Sign up by user data
func PostSignUp(c *fiber.Ctx) error {
	// Get body
	loginInfo := SignUpInfo{}
	if err := c.BodyParser(&loginInfo); err != nil {
		return err
	}

	// Save on Database
	if err := loginInfo.SaveDB(); err != nil {
		return nil
	}

	return c.SendStatus(fiber.StatusCreated)
}