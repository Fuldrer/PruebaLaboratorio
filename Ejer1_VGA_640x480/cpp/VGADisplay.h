#ifndef _VGA_DISPLAY_H

#define _VGA_DISPLAY_H

#include <vector>
#include <cstdint>
#include <SDL.h>
#include "VVGA640x480.h"
#include "VVGA640x480_VGA640x480.h"

class VGADisplay {
public:
  VGADisplay(VVGA640x480& vgam, int width, int height):
    width(width), height(height), vgam(vgam),
    window(nullptr), renderer(nullptr),
    frameBuff(width * height) {}

  ~VGADisplay();

  bool initDisplay();
  void clockPulse(uint8_t red, uint8_t green, uint8_t blue);
  void paint();
  void saveScreenshot(const char *filename);
  bool isWindowClosed();

  void getResolution(int &width, int &height) {
      width = this->width;
      height = this->height;
  }

private:
    struct Color {
        uint8_t red;
        uint8_t green;
        uint8_t blue;
    };

private:
    SDL_Window *window;
    SDL_Renderer *renderer;
    int width, height; 	// Screen resolution
    std::vector<Color> frameBuff;
    VVGA640x480& vgam;
};

#endif
