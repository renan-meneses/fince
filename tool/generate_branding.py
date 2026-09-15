#!/usr/bin/env python3
"""Generates Fince branding assets (banner, logo, app icon).

Usage:  python3 tool/generate_branding.py
Output: docs/assets/{banner,logo,icon}.png
"""
from __future__ import annotations

import os

import numpy as np
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "..", "docs", "assets")
FONT_DIR = "/usr/share/fonts/truetype/noto"

PRIMARY = (11, 110, 79)       # #0B6E4F
PRIMARY_LIGHT = (20, 148, 107)  # #14946B
INCOME = (27, 158, 119)       # #1B9E77
DARK = (11, 18, 23)           # #0B1217
SURFACE = (18, 20, 23)        # #121417
WHITE = (255, 255, 255)


def _font(name: str, size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(os.path.join(FONT_DIR, name), size)


def vertical_gradient(size, top, bottom):
    w, h = size
    top = np.array(top, dtype=float)
    bottom = np.array(bottom, dtype=float)
    rows = np.linspace(0, 1, h)[:, None, None]
    grad = top[None, None, :] * (1 - rows) + bottom[None, None, :] * rows
    grad = np.repeat(grad, w, axis=1).astype(np.uint8)
    return Image.fromarray(grad, "RGB")


def draw_text(draw, xy, text, font, fill, anchor_center=False):
    bbox = draw.textbbox((0, 0), text, font=font)
    w, h = bbox[2] - bbox[0], bbox[3] - bbox[1]
    x, y = xy
    if anchor_center:
        x -= w / 2
        y -= h / 2
    draw.text((x, y), text, font=font, fill=fill)


def banner():
    W, H = 1200, 630
    img = vertical_gradient((W, H), (10, 90, 64), (9, 16, 22)).convert("RGB")
    draw = ImageDraw.Draw(img, "RGBA")

    # subtle decorative rings / glow on the right
    for radius, alpha in [(360, 14), (300, 12), (240, 10)]:
        draw.ellipse(
            (W - radius - 60, H - radius - 60, W + radius - 60, H + radius - 60),
            outline=(255, 255, 255, alpha),
            width=2,
        )

    title = _font("NotoSans-Bold.ttf", 128)
    subtitle = _font("NotoSans-Regular.ttf", 40)
    tag = _font("NotoSans-Regular.ttf", 22)

    draw_text(draw, (80, 120), "Fince", title, WHITE)
    draw_text(draw, (82, 270), "Personal Finance Manager", subtitle, (255, 255, 255, 216))

    # feature pills
    pills = ["Offline-first", "Clean Architecture", "Flutter", "Drift / SQLite"]
    pill_font = _font("NotoSans-Regular.ttf", 24)
    x = 82
    for pill in pills:
        bbox = draw.textbbox((0, 0), pill, font=pill_font)
        pw = bbox[2] - bbox[0] + 44
        draw.rounded_rectangle(
            (x, 350, x + pw, 398), radius=24, fill=(255, 255, 255, 18)
        )
        draw.text((x + 22, 360), pill, font=pill_font, fill=(255, 255, 255, 230))
        x += pw + 16

    # --- credit card (right) ---
    card = (700, 200, 1120, 400)
    card_img = vertical_gradient(
        (card[2] - card[0], card[3] - card[1]), PRIMARY_LIGHT, PRIMARY
    ).convert("RGBA")
    card_draw = ImageDraw.Draw(card_img)
    card_draw.rounded_rectangle(
        (0, 0, card[2] - card[0] - 1, card[3] - card[1] - 1),
        radius=28,
        outline=(255, 255, 255, 60),
        width=2,
    )
    card_draw.text((28, 26), "VISA", font=_font("NotoSans-Bold.ttf", 34), fill=WHITE)
    card_draw.text(
        (28, 96),
        "\u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  1234",
        font=_font("NotoSans-Regular.ttf", 30),
        fill=WHITE,
    )
    card_draw.text((28, 152), "ADA DEMO", font=_font("NotoSans-Bold.ttf", 26), fill=(255, 255, 255, 230))
    # chip
    card_draw.rounded_rectangle((340, 24, 390, 58), radius=8, fill=(240, 200, 120))
    img.paste(card_img, (card[0], card[1]), card_img)

    # rising line chart behind/left of card
    pts = [(680, 420), (780, 390), (880, 405), (980, 360), (1090, 320)]
    draw.line(pts, fill=(27, 158, 119, 255), width=6, joint="curve")
    for p in pts:
        draw.ellipse((p[0] - 7, p[1] - 7, p[0] + 7, p[1] + 7), fill=WHITE)

    # footer
    draw_text(
        draw,
        (W / 2, 590),
        "flutter \u00b7 drift \u00b7 bloc \u00b7 dio \u00b7 fl_chart \u00b7 get_it \u00b7 go_router",
        tag,
        (255, 255, 255, 140),
        anchor_center=True,
    )

    return img


def logo(size=512):
    img = vertical_gradient((size, size), PRIMARY_LIGHT, PRIMARY).convert("RGB")
    draw = ImageDraw.Draw(img, "RGBA")
    radius = size // 4
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, size - 1, size - 1), radius=radius, fill=255)
    # put gradient inside rounded mask
    bg = vertical_gradient((size, size), PRIMARY_LIGHT, PRIMARY).convert("RGB")
    img = Image.composite(bg, Image.new("RGB", (size, size), DARK), mask)
    draw = ImageDraw.Draw(img, "RGBA")

    # growth accent (rising bars) behind the F
    bars = [(300, 300), (340, 260), (380, 210)]
    for i, (x, y) in enumerate(bars):
        draw.rounded_rectangle((x, y, x + 34, 360), radius=8, fill=(255, 255, 255, 90))

    draw_text(
        draw, (size / 2, size / 2 + 8), "F",
        _font("NotoSans-Bold.ttf", size // 2), WHITE, anchor_center=True,
    )
    return img


def main():
    os.makedirs(OUT, exist_ok=True)
    banner().save(os.path.join(OUT, "banner.png"))
    logo().save(os.path.join(OUT, "logo.png"))
    logo(1024).save(os.path.join(OUT, "icon.png"))
    print("Wrote:", os.path.join(OUT, "banner.png"))
    print("Wrote:", os.path.join(OUT, "logo.png"))
    print("Wrote:", os.path.join(OUT, "icon.png"))


if __name__ == "__main__":
    main()
