#!/usr/bin/env python3
"""Build 1280x769 Fiverr gallery images from Driftwell simulator captures."""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
CAPTURES = ROOT / "outputs" / "driftwell-ios"
GALLERY = CAPTURES / "gallery"
GALLERY.mkdir(parents=True, exist_ok=True)

W, H = 1280, 769
PLUM = "#4B2A4F"
CORAL = "#F48B7A"
CREAM = "#FFF9F3"
BLUSH = "#FFF2ED"
INK = "#252025"
SAGE = "#DDE9DE"
MUTED = "#746C72"
FONT = "/System/Library/Fonts/SFNS.ttf"
ROUND_FONT = "/System/Library/Fonts/SFNSRounded.ttf"


def font(size: int, bold: bool = False):
    # The bundled SF fonts expose bold faces through their collection metadata.
    return ImageFont.truetype(ROUND_FONT if bold else FONT, size=size)


def rounded(draw, box, radius, fill, outline=None, width=1):
    draw.rounded_rectangle(box, radius=radius, fill=fill, outline=outline, width=width)


def phone(canvas, capture_name: str, x: int, y: int, height: int, shadow=True):
    source = Image.open(CAPTURES / capture_name).convert("RGB")
    width = round(source.width * height / source.height)
    source = source.resize((width, height), Image.Resampling.LANCZOS)
    mask = Image.new("L", (width, height), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, width, height), radius=35, fill=255)
    if shadow:
        shadow_layer = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
        sd = ImageDraw.Draw(shadow_layer)
        sd.rounded_rectangle((x + 9, y + 13, x + width + 9, y + height + 13), radius=39, fill=(45, 28, 42, 48))
        canvas.alpha_composite(shadow_layer)
    frame = Image.new("RGBA", (width + 12, height + 12), (0, 0, 0, 0))
    ImageDraw.Draw(frame).rounded_rectangle((0, 0, width + 11, height + 11), radius=41, fill=PLUM)
    # Paste the screen inside a slim plum frame.
    screen_layer = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    screen_layer.paste(source, (0, 0), mask)
    canvas.alpha_composite(frame, (x - 6, y - 6))
    canvas.alpha_composite(screen_layer, (x, y))
    return width


def label(draw, xy, text, fill=PLUM):
    x, y = xy
    bbox = draw.textbbox((0, 0), text, font=font(16, True))
    pad_x, pad_y = 15, 10
    rounded(draw, (x, y, x + bbox[2] + pad_x * 2, y + bbox[3] + pad_y * 2), 18, fill)
    draw.text((x + pad_x, y + pad_y - 2), text, font=font(16, True), fill="white")


def gallery_one():
    canvas = Image.new("RGBA", (W, H), CREAM)
    draw = ImageDraw.Draw(canvas)
    draw.ellipse((955, -190, 1375, 230), fill=CORAL)
    draw.ellipse((-170, 600, 240, 1010), fill=SAGE)
    label(draw, (70, 62), "NATIVE iOS · SWIFTUI")
    draw.multiline_text((70, 145), "Turn your app idea\ninto something you\ncan actually tap.", font=font(57, True), fill=INK, spacing=2)
    draw.multiline_text((74, 405), "Custom screens, native navigation, and a\nworking prototype flow built for iPhone.", font=font(23), fill=MUTED, spacing=8)
    chips = ["Original interface", "Interactive flow", "Source code"]
    y = 518
    for chip in chips:
        rounded(draw, (72, y, 330, y + 52), 18, "white", outline="#E7DCD8", width=2)
        draw.ellipse((89, y + 17, 107, y + 35), fill=PLUM)
        draw.text((121, y + 13), chip, font=font(18, True), fill=INK)
        y += 63
    phone(canvas, "01-home.png", 865, 74, 650)
    draw.text((72, 720), "DRIFTWELL · FICTIONAL PORTFOLIO CONCEPT", font=font(13, True), fill=PLUM)
    canvas.convert("RGB").save(GALLERY / "01-driftwell-ios-primary.png", quality=95)


def gallery_two():
    canvas = Image.new("RGBA", (W, H), PLUM)
    draw = ImageDraw.Draw(canvas)
    draw.text((54, 42), "A COMPLETE BOOKING JOURNEY", font=font(35, True), fill="white")
    draw.text((56, 91), "Specialist → time → review", font=font(21), fill="#E9DCE9")
    draw.ellipse((1080, -95, 1370, 195), fill=CORAL)
    specs = [
        ("02-provider.png", 126, "CHOOSE A SPECIALIST"),
        ("03-time.png", 499, "PICK A DATE & TIME"),
        ("04-review.png", 872, "REVIEW THE DETAILS"),
    ]
    for name, x, caption in specs:
        pw = phone(canvas, name, x, 142, 555, shadow=False)
        rounded(draw, (x - 8, 716, x + pw + 8, 754), 16, "#FFFFFF")
        tw = draw.textbbox((0, 0), caption, font=font(13, True))[2]
        draw.text((x + (pw - tw) / 2, 727), caption, font=font(13, True), fill=PLUM)
    canvas.convert("RGB").save(GALLERY / "02-driftwell-ios-flow.png", quality=95)


def gallery_three():
    canvas = Image.new("RGBA", (W, H), BLUSH)
    draw = ImageDraw.Draw(canvas)
    draw.ellipse((-160, -170, 245, 235), fill=SAGE)
    draw.text((66, 63), "POLISHED, TESTABLE, READY TO HAND OFF", font=font(32, True), fill=INK)
    draw.text((68, 108), "A focused prototype gives you a real iPhone experience before a larger build.", font=font(20), fill=MUTED)
    phone(canvas, "05-confirmation.png", 91, 171, 535)
    phone(canvas, "06-bookings.png", 381, 171, 535)
    rounded(draw, (735, 178, 1210, 658), 30, "white")
    draw.text((782, 225), "Included in the prototype", font=font(26, True), fill=INK)
    items = [
        ("01", "Up to 5 custom screens"),
        ("02", "Native SwiftUI navigation"),
        ("03", "Local sample data"),
        ("04", "App icon and source code"),
        ("05", "Two revision rounds"),
    ]
    y = 297
    for number, text in items:
        rounded(draw, (782, y, 825, y + 43), 13, SAGE)
        draw.text((793, y + 10), number, font=font(14, True), fill=PLUM)
        draw.text((846, y + 9), text, font=font(19, True), fill=INK)
        y += 59
    rounded(draw, (782, 596, 1156, 638), 17, PLUM)
    draw.text((807, 606), "FRONT-END PROTOTYPE SCOPE", font=font(15, True), fill="white")
    draw.text((68, 729), "DRIFTWELL · FICTIONAL PORTFOLIO CONCEPT · NO REAL BOOKINGS OR PAYMENTS", font=font(13, True), fill=PLUM)
    canvas.convert("RGB").save(GALLERY / "03-driftwell-ios-scope.png", quality=95)


if __name__ == "__main__":
    gallery_one()
    gallery_two()
    gallery_three()
    for path in sorted(GALLERY.glob("*.png")):
        with Image.open(path) as image:
            print(f"{path.relative_to(ROOT)}: {image.width}x{image.height}")
