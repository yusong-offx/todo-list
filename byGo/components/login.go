package components

import "github.com/gofiber/fiber/v2"

type LoginInfo struct {
	ID  string `json:"login_id"`
	Pwd []byte `json:"login_password"`
}

func (l LoginInfo) isValid() error {
	return nil
}

func PostLoginFunc(c *fiber.Ctx) error {
	logininfo := LoginInfo{}
	if err := c.BodyParser(&logininfo); err != nil {
		return err
	}
	if err := logininfo.isValid(); err != nil {
		return err
	}
	// Generate JWT
	return c.SendStatus(fiber.StatusOK)
}
