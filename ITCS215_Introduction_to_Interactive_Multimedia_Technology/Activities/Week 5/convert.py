from PIL import Image
from pathlib import Path

# Path to your images directory
folder_path = Path.cwd() / input("Enter the Folder Name: ").strip()

for file_path in folder_path.iterdir():
    if file_path.suffix.lower() in [".webp", ".avif", ".png", ".svg"]:
        try:
            with Image.open(file_path) as img:
                # Convert RGBA/palette images to standard RGB
                rgb_img = img.convert("RGB")
                new_file_path = file_path.with_suffix(".jpg")
                rgb_img.save(new_file_path, "JPEG")
            
            # Remove the original non-standard file
            file_path.unlink()
        except Exception as e:
            print(f"Error converting {file_path.name}: {e}")
