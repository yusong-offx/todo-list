package components

import (
	"time"

	"github.com/gofiber/fiber/v2"
)

type Todo struct {
	Title            string    `json:"title"`
	Contents         string    `json:"contents"`
	CreateDate       time.Time `josn:"create_date"`
	LastModifiedDate time.Time `json:"lastmodified_date"`
}

func PostTodo(c *fiber.Ctx) error {
	todo := Todo{}
	if err := c.BodyParser(&todo); err != nil {
		return err
	}

	return c.SendStatus(fiber.StatusCreated)
}
