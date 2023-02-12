package components

import (
	"strconv"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

type Todo struct {
	ID               int       `json:"id"`
	UserID           int       `json:"user_id"`
	Title            string    `json:"title"`
	Contents         string    `json:"contents"`
	CreateDate       time.Time `json:"create_date"`
	LastModifiedDate time.Time `json:"lastmodified_date"`
}

// Save todo element on DB
func (t Todo) SaveDB() error {
	// Insert into DB
	// Time default now
	if _, err := DB.Exec(
		"INSERT INTO TODOS (user_id, title, contents) VALUES ($1, $2, $3)",
		t.UserID, t.Title, t.Contents,
	); err != nil {
		return err
	}
	return nil
}

func PostTodo(c *fiber.Ctx) error {
	// Get body
	todo := Todo{}
	if err := c.BodyParser(&todo); err != nil {
		return err
	}
	// Compare request_user_id and jwt_user_id
	if !UserCheck(c, todo.UserID) {
		return c.SendStatus(fiber.StatusUnauthorized)
	}
	// Save on DB
	if err := todo.SaveDB(); err != nil {
		return err
	}
	// Response 201
	return c.SendStatus(fiber.StatusCreated)
}

// Get todo elements by user_id
func GetTodoByUserID(c *fiber.Ctx) error {
	// Get user_id from parameter
	userID := c.Params("id")
	// Compare request_user_id and jwt_user_id
	switch intID, err := strconv.Atoi(userID); err {
	case nil:
		if !UserCheck(c, intID) {
			return c.SendStatus(fiber.StatusUnauthorized)
		}
	default:
		return err
	}
	// Get todos from DB
	switch rows, err := DB.Query(
		"SELECT * FROM TODOS WHERE user_id = $1",
		userID); err {
	case nil:
		todos, el := []Todo{}, Todo{}
		for rows.Next() {
			if err := rows.Scan(
				&el.ID,
				&el.UserID,
				&el.Title,
				&el.Contents,
				&el.CreateDate,
				&el.LastModifiedDate,
			); err != nil {
				return err
			}
			todos = append(todos, el)
		}
		return c.JSON(todos)
	// If no query, response 400
	default:
		return c.SendStatus(fiber.StatusBadRequest)
	}
}

// Delete todo element by todo_id
func DeleteTodoByID(c *fiber.Ctx) error {
	// Get todo_id from parameter
	todoID := c.Params("id")

	// Get jwt token from context
	// Get claims from jwt token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(jwt.MapClaims)
	jwtID := int(claims["user_id"].(float64))

	// Delete from DB
	if _, err := DB.Exec(
		"DELETE FROM TODOS WHERE id = $1 and user_id = $2",
		todoID,
		jwtID,
	); err != nil {
		return err
	}
	// Response 200
	return c.SendStatus(fiber.StatusOK)
}

func PutTodoByID(c *fiber.Ctx) error {
	// Get update source from body
	todo := Todo{}
	if err := c.BodyParser(&todo); err != nil {
		return err
	}
	// Compare request_user_id and jwt_user_id
	if !UserCheck(c, todo.UserID) {
		return c.SendStatus(fiber.StatusUnauthorized)
	}
	// Update from DB
	if _, err := DB.Exec(
		"UPDATE TODOS SET title=$1, contents=$2, lastmodified_date=$3 WHERE id = $4",
		todo.Title,
		todo.Contents,
		time.Now(),
		todo.ID,
	); err != nil {
		return err
	}
	return c.SendStatus(fiber.StatusOK)
}
