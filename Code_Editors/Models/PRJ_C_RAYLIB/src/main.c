#include "raylib.h"

#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

#define SCREEN_TITLE "Game"
#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600

#define TIMER_FPS 60 // target frames per second

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

typedef enum {
    STATE_PLAYING,
    STATE_PAUSE,
    STATE_WIN,
    STATE_GAMEOVER,
    STATE_QUIT
} GameState;

typedef struct {
    // structures
    GameState state;
} Game;

// ---------------------------------------------------------------------------
// Prototypes
// ---------------------------------------------------------------------------

static void GameInit(Game* game);
static void GameStartLevel(Game* game);
static void GameFreeLevel(Game* game);
static void GameHandleInput(Game* game);
static void GameUpdate(Game* game);
static void GameRender(const Game* game);
static void GameCheckCollisions(Game* game);
static bool GameLevelComplete(const Game* game);
static void GameQuit(Game* game);

static bool CheckCircleCollision(Vector2 point, Vector2 center, float radius);
static bool PointInArea(Vector2 v);
static float Vec2Distance(Vector2 a, Vector2 b);

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

int main(void)
{
    // Window
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE);
    SetTargetFPS(TIMER_FPS);

    // Initialize Game
    Game game = { 0 };
    GameInit(&game);

    // Game Loop
    while (!WindowShouldClose() && game.state != STATE_QUIT) {
        // Keyboard and Mouse Events
        GameHandleInput(&game);

        // Update
        if (game.state == STATE_PLAYING)
            GameUpdate(&game);

        // Render
        BeginDrawing();
        {
            ClearBackground(DARKGRAY);
            GameRender(&game);
        }
        EndDrawing();
    }

    // Exit
    GameQuit(&game);
    CloseWindow();

    return 0;
}

// ---------------------------------------------------------------------------
// Game logic
// ---------------------------------------------------------------------------

static void GameInit(Game* game)
{
    GameFreeLevel(game);

    // TO DO

    game->state = STATE_PLAYING;
    GameStartLevel(game);
}

static void GameStartLevel(Game* game)
{
    GameFreeLevel(game);

    // TO DO

    game->state = STATE_PLAYING;
}

static void GameFreeLevel(Game* game)
{
    // TO DO
}

static void GameHandleInput(Game* game)
{
    // Pause / resume
    if (IsKeyPressed(KEY_P)) {
        if (game->state == STATE_PLAYING) {
            // TO DO
            game->state = STATE_PAUSE;
        } else if (game->state == STATE_PAUSE) {
            // TO DO
            game->state = STATE_PLAYING;
        }
    }

    // Restart
    if (IsKeyPressed(KEY_R))
        GameInit(game);

    // Quit
    if (IsKeyPressed(KEY_Q))
        game->state = STATE_QUIT;

    // Restart after game over
    if (game->state == STATE_GAMEOVER && IsKeyPressed(KEY_SPACE))
        GameInit(game);

    // Move cursor
    if (game->state == STATE_PLAYING && IsMouseButtonPressed(MOUSE_BUTTON_LEFT)) {
        // TO DO
    }
}

static void GameUpdate(Game* game)
{
    GameCheckCollisions(game);

    if (GameLevelComplete(game)) {
        GameStartLevel(game);
    }
}

static void GameRender(const Game* game)
{
    // Playing area background

    // Objects
    // DrawHud(game);

    if (game->state == STATE_PAUSE)
        DrawOverlay("PAUSED  [P to resume]", (Color) { 0, 0, 0, 160 }, RAYWHITE);

    if (game->state == STATE_GAMEOVER)
        DrawOverlay("GAME OVER  [SPACE to restart]", (Color) { 0, 0, 0, 200 }, RED);
}

static void GameCheckCollisions(Game* game)
{
    // TO DO
}

static bool GameLevelComplete(const Game* game)
{
    // TO DO

    return true;
}

static void GameQuit(Game* game)
{
    GameFreeLevel(game);
}

// ---------------------------------------------------------------------------
// Render helpers
// ---------------------------------------------------------------------------

// static void DrawHud(const Game* game)
// {
//     // TO DO
// }

// ---------------------------------------------------------------------------
// Geometry / collision
// ---------------------------------------------------------------------------

static bool CheckCircleCollision(Vector2 point, Vector2 center, float radius)
{
    return Vec2Distance(point, center) <= radius;
}

static float Vec2Distance(Vector2 a, Vector2 b)
{
    return sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y));
}

static bool PointInArea(Vector2 v)
{
    return v.x >= AREA_X && v.x <= AREA_X + AREA_W && v.y >= AREA_Y && v.y <= AREA_Y + AREA_H;
}
