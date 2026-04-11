# Evidence Collector - Kali Linux Tool Mapping

**Agent:** 📸 Evidence Collector  
**Created:** April 10, 2026  
**Kali Version:** 2026.1  
**Total Tools:** 15  
**Status:** Complete

---

## Overview

**Mission:** QA testing with visual proof, interactive element testing, and spec compliance verification.

**Primary Use Cases:**
- Screenshot and screen recording
- Visual documentation
- Interactive element testing
- Compliance evidence collection
- Test automation with visual proof
- Report generation with visual evidence

---

## 1. Screenshot & Capture

### Screenshot Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **flameshot** | flameshot | Screenshot tool | `flameshot gui` |
| **shutter** | shutter | Screenshot editor | `shutter` (GUI) |
| **scrot** | scrot | Command-line capture | `scrot output.png` |
| **maim** | maim | Screenshot utility | `maim screenshot.png` |
| **import** | imagemagick | ImageMagick capture | `import -window root screen.png` |

### Flameshot Usage
```bash
# Interactive screenshot
flameshot gui

# Full screen capture
flameshot full -p ~/screenshots/

# Specific monitor
flameshot screen -n 0

# With delay
flameshot gui -d 5000
```

---

## 2. Screen Recording

### Recording Tools

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **obs-studio** | obs-studio | Screen recording | `obs` (GUI) |
| **simplescreenrecorder** | simplescreenrecorder | Simple recording | GUI application |
| **peek** | peek | GIF recording | `peek` (GUI) |
| **asciinema** | asciinema | Terminal recording | `asciinema rec` |
| **ffmpeg** | ffmpeg | Video capture | `ffmpeg -f x11grab -i :0.0 output.mp4` |

### OBS Studio Setup
```
1. Add Source → Display Capture
2. Configure output settings:
   - Format: MP4
   - Quality: High
   - FPS: 30
3. Start Recording
```

### Asciinema Usage
```bash
# Start recording
asciinema rec session.cast

# Play back recording
asciinema play session.cast

# Upload to asciinema.org
asciinema upload session.cast

# Embed in documentation
# Use provided embed code
```

---

## 3. Visual Testing

### Visual Regression

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **playwright** | playwright (npm) | Browser automation | `npx playwright test` |
| **selenium** | selenium (pip) | Browser automation | `python3 test.py` |
| **cypress** | cypress (npm) | E2E testing | `npx cypress run` |
| **backstopjs** | backstopjs (npm) | Visual regression | `backstop test` |

### Playwright Example
```javascript
// test.spec.js
const { test, expect } = require('@playwright/test');

test('visual regression', async ({ page }) => {
  await page.goto('http://target.com');
  await expect(page).toHaveScreenshot('homepage.png');
});

test('interactive element', async ({ page }) => {
  await page.goto('http://target.com/login');
  await page.fill('#username', 'test');
  await page.fill('#password', 'password');
  await page.click('#submit');
  await page.screenshot({ path: 'logged-in.png' });
});
```

---

## 4. Documentation Tools

### Note Taking

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **cherrytree** | cherrytree | Hierarchical notes | `cherrytree` (GUI) |
| **joplin** | joplin | Note taking | `joplin` (GUI/CLI) |
| **obsidian** | obsidian (manual) | Knowledge base | Desktop app |
| **keepnote** | keepnote | Note taking | `keepnote` (GUI) |

---

## 5. Test Automation

### Testing Frameworks

| Tool | Package | Purpose | Command Example |
|------|---------|---------|-----------------|
| **pytest** | pytest | Python testing | `pytest -v tests/` |
| **jest** | jest (npm) | JavaScript testing | `npx jest` |
| **robot-framework** | robotframework | Acceptance testing | `robot tests.robot` |

### Robot Framework Example
```robot
*** Settings ***
Library    SeleniumLibrary
Library    Screenshot

*** Test Cases ***
Login Page Test
    Open Browser    http://target.com/login    chrome
    Input Text    id=username    testuser
    Input Password    id=password    password
    Click Button    id=submit
    Capture Page Screenshot    login-success.png
    Page Should Contain    Welcome
    [Teardown]    Close Browser
```

---

## Top 10 Evidence Collector Tools

| # | Tool | Category | Why Essential |
|---|------|----------|---------------|
| 1 | **Flameshot** | Screenshot | Fast, annotated screenshots |
| 2 | **OBS Studio** | Recording | Professional screen recording |
| 3 | **Asciinema** | Terminal | Terminal session recording |
| 4 | **Playwright** | Testing | Modern browser automation |
| 5 | **Selenium** | Testing | Industry-standard automation |
| 6 | **FFmpeg** | Recording | Versatile video capture |
| 7 | **CherryTree** | Documentation | Hierarchical note-taking |
| 8 | **Pytest** | Testing | Python test framework |
| 9 | **Scrot** | Screenshot | Simple CLI screenshots |
| 10 | **Peek** | GIF | Animated GIF recording |

---

## Quick Reference Commands

### Screenshot Workflow
```bash
# Interactive screenshot with annotation
flameshot gui

# Full screen with timestamp
scrot '%Y-%m-%d_%H-%M-%S_$wx$h.png'

# Specific window
maim -w $(xdotool getactivewindow) window.png

# Multiple monitors
maim -m 0 monitor1.png
maim -m 1 monitor2.png
```

### Recording Workflow
```bash
# Terminal session
asciinema rec security-test.cast

# Screen recording (FFmpeg)
ffmpeg -f x11grab -s 1920x1080 -i :0.0 -c:v libx264 output.mp4

# GIF recording
peek &
```

### Visual Testing Workflow
```bash
# Run Playwright tests
npx playwright test --reporter=html

# Generate visual report
npx playwright show-report

# Run with screenshots
npx playwright test --screenshot=on
```

---

## Pre-Installed vs Manual Install

### Pre-Installed in Kali 2026.1

| Category | Tools |
|----------|-------|
| **Screenshot** | Flameshot, Scrot, ImageMagick |
| **Recording** | FFmpeg, Asciinema |
| **Testing** | Pytest, Selenium |

### Manual Install Required

| Tool | Install Method | Notes |
|------|----------------|-------|
| **OBS Studio** | apt | Screen recording |
| **Playwright** | npm | Browser automation |
| **Cypress** | npm | E2E testing |
| **BackstopJS** | npm | Visual regression |
| **Obsidian** | Download | Knowledge base |
| **Joplin** | apt/npm | Note taking |
| **Robot Framework** | pip | Acceptance testing |

---

## Evidence Collection Best Practices

### Screenshot Standards
- [ ] Include timestamp in filename
- [ ] Annotate important elements
- [ ] Capture full context
- [ ] Use consistent naming convention
- [ ] Store in organized directory structure

### Recording Standards
- [ ] Test audio before recording
- [ ] Use appropriate resolution
- [ ] Keep recordings under 10 minutes
- [ ] Add chapter markers for long sessions
- [ ] Export in common formats (MP4, GIF)

### Documentation Standards
- [ ] Link screenshots to test cases
- [ ] Include environment details
- [ ] Document steps to reproduce
- [ ] Store evidence with reports
- [ ] Maintain chain of custody

---

**Document Version:** 1.0  
**Created:** April 10, 2026  
**Author:** KaliKlaw Security Assistant  
**Next Review:** Quarterly  
**Owner:** Security Team
