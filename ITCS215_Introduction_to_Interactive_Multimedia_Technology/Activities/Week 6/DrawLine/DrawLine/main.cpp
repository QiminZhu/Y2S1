// Suppress compiler deprecation warnings for legacy OpenGL functions on macOS.
// A preprocessor directive—which is like an instruction card pinned to a recipe before cooking begins—guides the compiler prior to compilation.
#define GL_SILENCE_DEPRECATION

#include <OpenGL/gl.h>
#include <GLUT/glut.h>
#include <cmath>
#include <vector>
#include <algorithm>

// -----------------------------------------------------------------
// Window Configurations & State Storage
// -----------------------------------------------------------------

// Current window dimensions in screen pixels
int windowWidth = 600;
int windowHeight = 400;

// Representation of a single 2D integer pixel coordinate
struct Point {
    int x, y;
};

// Representation of an edge connecting two 2D points
struct LineSegment {
    int x0, y0, x1, y1;
};

// List of all confirmed polygon edges drawn interactively by the user
std::vector<LineSegment> userPolygonEdges;

// Chronological sequence of active vertices placed during left clicks
std::vector<Point> activeVertices;

// -----------------------------------------------------------------
// Primitive Plotting Helper
// -----------------------------------------------------------------

// Converts normalized screen coordinates into a plotted OpenGL dot.
// Normalized Device Coordinates (NDC)—which are like converting diverse currencies into a single universal baseline currency—scale coordinates to the [-1.0, 1.0] range.
void plotPoint(float normX, float normY) {
    glBegin(GL_POINTS);
        glVertex2f(normX, normY);
    glEnd();
}

// -----------------------------------------------------------------
// Algorithm 1: Digital Differential Analyzer (DDA)
// -----------------------------------------------------------------
// Samples points along the line using floating-point increments and rounding.
void drawLineDDA(int x0, int y0, int x1, int y1) {
    int dx = x1 - x0;
    int dy = y1 - y0;

    // The larger delta dictates total steps to guarantee an unbroken line.
    int steps = (std::abs(dx) >= std::abs(dy)) ? std::abs(dx) : std::abs(dy);

    // Compute the floating-point increment applied at each step.
    // Floating-point arithmetic—which is like measuring liquid using a precision eye-dropper down to fractional drops—tracks fractional movement along the minor axis.
    float xInc = dx / (float)steps;
    float yInc = dy / (float)steps;

    float x = x0;
    float y = y0;

    for (int i = 0; i <= steps; i++) {
        // Map pixel coordinates [0, width] and [0, height] to [-1.0, 1.0]
        float normX = (std::round(x) / windowWidth) * 2.0f - 1.0f;
        float normY = (std::round(y) / windowHeight) * 2.0f - 1.0f;
        plotPoint(normX, normY);

        x += xInc;
        y += yInc;
    }
}

// -----------------------------------------------------------------
// Algorithm 2: Bresenham's Line Algorithm
// -----------------------------------------------------------------
// Rasterizes shallow lines (0 <= m <= 1, x0 <= x1) strictly through integer addition and subtraction.
void drawLineBresenham(int x0, int y0, int x1, int y1) {
    int dx = x1 - x0;
    int dy = y1 - y0;

    // Initial decision parameter: p0 = 2*dy - dx
    // A decision parameter—which is like a mechanical two-sided balance scale tipping left or right—determines whether the true mathematical line sits closer to the straight or diagonal pixel.
    int p = 2 * dy - dx;
    int x = x0;
    int y = y0;

    while (x <= x1) {
        float normX = ((float)x / windowWidth) * 2.0f - 1.0f;
        float normY = ((float)y / windowHeight) * 2.0f - 1.0f;
        plotPoint(normX, normY);

        // Case 1: Midpoint is above the line -> keep current y
        if (p < 0) {
            p += 2 * dy;
        }
        // Case 2: Midpoint is below or on the line -> increment y
        else {
            p += 2 * dy - 2 * dx;
            y++;
        }
        x++;
    }
}

// -----------------------------------------------------------------
// Algorithm 3: Midpoint Line Algorithm
// -----------------------------------------------------------------
// Evaluates whether the line passes above or below the midpoint between candidate pixels.
void drawLineMidpoint(int x0, int y0, int x1, int y1) {
    int dx = x1 - x0;
    int dy = y1 - y0;

    // Initial decision value and second-case incremental step
    int D = 2 * dy - dx;
    int deltaD = 2 * (dy - dx);

    int x = x0;
    int y = y0;

    while (x <= x1) {
        float normX = ((float)x / windowWidth) * 2.0f - 1.0f;
        float normY = ((float)y / windowHeight) * 2.0f - 1.0f;
        plotPoint(normX, normY);

        // Case 1: Select East pixel (y remains unchanged)
        if (D < 0) {
            D += 2 * dy;
        }
        // Case 2: Select North-East pixel (step diagonally)
        else {
            D += deltaD;
            y++;
        }
        x++;
    }
}

// -----------------------------------------------------------------
// Generalized Bresenham (Arbitrary Slopes & Directions)
// -----------------------------------------------------------------
// Extends integer rasterization across all 8 octants, enabling mouse-drawn lines in any direction.
// An all-octant algorithm—which is like an all-wheel-drive vehicle capable of driving uphill, downhill, or in reverse—accommodates arbitrary angles without restriction.
void drawLineAllOctants(int x0, int y0, int x1, int y1) {
    int dx = std::abs(x1 - x0);
    int dy = std::abs(y1 - y0);
    int sx = (x0 < x1) ? 1 : -1; // Horizontal direction step (+1 or -1)
    int sy = (y0 < y1) ? 1 : -1; // Vertical direction step (+1 or -1)
    int err = dx - dy;           // Accumulation error balance

    while (true) {
        float normX = ((float)x0 / windowWidth) * 2.0f - 1.0f;
        float normY = ((float)y0 / windowHeight) * 2.0f - 1.0f;
        plotPoint(normX, normY);

        if (x0 == x1 && y0 == y1) break;

        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x0 += sx;
        }
        if (e2 < dx) {
            err += dx;
            y0 += sy;
        }
    }
}

// -----------------------------------------------------------------
// Display Callback
// -----------------------------------------------------------------
// Invoked automatically whenever the window buffer requires redrawing.
void display() {
    // Clear the canvas buffer before rendering the new frame
    glClear(GL_COLOR_BUFFER_BIT);
    glPointSize(3.0f);

    // --- Deliverable 1: Static Algorithm Verification (Slide 135) ---
    // Render three benchmark lines demonstrating each core algorithm

    // 1. DDA Line (Red)
    glColor3f(1.0f, 0.2f, 0.2f);
    drawLineDDA(30, 80, 180, 120);

    // 2. Bresenham Line (Green)
    glColor3f(0.2f, 1.0f, 0.2f);
    drawLineBresenham(30, 180, 180, 220);

    // 3. Midpoint Line (Blue)
    glColor3f(0.2f, 0.6f, 1.0f);
    drawLineMidpoint(30, 280, 180, 320);

    // --- Deliverable 2: Closed Polygon Drawing (Slide 136) ---
    // Render user-created polygon edges in yellow
    glColor3f(1.0f, 1.0f, 0.0f);
    for (const auto& edge : userPolygonEdges) {
        drawLineAllOctants(edge.x0, edge.y0, edge.x1, edge.y1);
    }

    // Highlight unclosed vertices with cyan anchor dots
    glColor3f(0.0f, 1.0f, 1.0f);
    glPointSize(6.0f);
    for (const auto& pt : activeVertices) {
        float normX = ((float)pt.x / windowWidth) * 2.0f - 1.0f;
        float normY = ((float)pt.y / windowHeight) * 2.0f - 1.0f;
        plotPoint(normX, normY);
    }

    // Push all queued drawing instructions immediately to the GPU
    glFlush();
}

// -----------------------------------------------------------------
// Window Reshape Callback
// -----------------------------------------------------------------
// Adjusts coordinate scaling whenever the display window is resized by the user.
// A viewport—which is like an adjustable picture frame opening that controls how much canvas is visible—recalibrates the render area.
void handleReshape(int w, int h) {
    windowWidth = w;
    windowHeight = h;
    glViewport(0, 0, w, h);
}

// -----------------------------------------------------------------
// Mouse Input Handler
// -----------------------------------------------------------------
// Handles sequential vertex chaining and polygon loop closure.
void handleMouse(int button, int state, int x, int y) {
    // Process actions only on initial button press down
    if (state != GLUT_DOWN) return;

    // Invert y: Operating systems place (0,0) at top-left; Cartesian systems place (0,0) at bottom-left
    int correctedY = windowHeight - y;

    // LEFT CLICK: Append vertex and chain an edge to the preceding vertex
    if (button == GLUT_LEFT_BUTTON) {
        Point newPt = { x, correctedY };

        if (!activeVertices.empty()) {
            Point lastPt = activeVertices.back();
            userPolygonEdges.push_back({ lastPt.x, lastPt.y, newPt.x, newPt.y });
        }

        activeVertices.push_back(newPt);
        glutPostRedisplay();
    }
    // RIGHT CLICK: Connect final vertex back to the first vertex to form a closed polygon
    else if (button == GLUT_RIGHT_BUTTON) {
        // Enforce a minimum of three vertices to create a valid polygon
        if (activeVertices.size() >= 3) {
            Point firstPt = activeVertices.front();
            Point lastPt = activeVertices.back();

            // Seal the perimeter loop
            userPolygonEdges.push_back({ lastPt.x, lastPt.y, firstPt.x, firstPt.y });

            // Reset active chain to finalize the polygon
            activeVertices.clear();
            glutPostRedisplay();
        }
    }
}

// -----------------------------------------------------------------
// Program Entry Point
// -----------------------------------------------------------------
int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitWindowSize(windowWidth, windowHeight);
    glutCreateWindow("Line Algorithms (Left) & Polygon Mouse Chaining (Right)");

    // Register callback handlers with GLUT
    glutDisplayFunc(display);
    glutReshapeFunc(handleReshape);
    glutMouseFunc(handleMouse);

    // Enter the blocking event processing loop
    // An event loop—which is like an automated revolving door that continuously spins to process arriving pedestrians—keeps the program listening for user actions.
    glutMainLoop();
    return 0;
}
