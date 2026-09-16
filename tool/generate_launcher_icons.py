#!/usr/bin/env python3
"""Generates the Android + iOS launcher icons from `assets/icon/icon.png`.

Usage:  python3 tool/generate_launcher_icons.py
"""
from __future__ import annotations

import os

from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..")
SOURCE = os.path.join(ROOT, "assets", "icon", "icon.png")

ANDROID = {
    "mdpi": 48,
    "hdpi": 72,
    "xhdpi": 96,
    "xxhdpi": 144,
    "xxxhdpi": 192,
}

# (path, size)
IOS = [
    ("Icon-App-20x20@1x.png", 20),
    ("Icon-App-20x20@2x.png", 40),
    ("Icon-App-20x20@3x.png", 60),
    ("Icon-App-29x29@1x.png", 29),
    ("Icon-App-29x29@2x.png", 58),
    ("Icon-App-29x29@3x.png", 87),
    ("Icon-App-40x40@1x.png", 40),
    ("Icon-App-40x40@2x.png", 80),
    ("Icon-App-40x40@3x.png", 120),
    ("Icon-App-60x60@2x.png", 120),
    ("Icon-App-60x60@3x.png", 180),
    ("Icon-App-76x76@1x.png", 76),
    ("Icon-App-76x76@2x.png", 152),
    ("Icon-App-83.5x83.5@2x.png", 167),
    ("Icon-App-1024x1024@1x.png", 1024),
]


def main():
    source = Image.open(SOURCE).convert("RGB")

    for density, size in ANDROID.items():
        out = os.path.join(
            ROOT, "android", "app", "src", "main", "res",
            f"mipmap-{density}", "ic_launcher.png",
        )
        source.resize((size, size), Image.LANCZOS).save(out)
        print("Wrote:", os.path.relpath(out, ROOT))

    ios_dir = os.path.join(
        ROOT, "ios", "Runner", "Assets.xcassets", "AppIcon.appiconset"
    )
    for name, size in IOS:
        out = os.path.join(ios_dir, name)
        source.resize((size, size), Image.LANCZOS).save(out)
        print("Wrote:", os.path.relpath(out, ROOT))


if __name__ == "__main__":
    main()
