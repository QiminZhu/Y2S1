from pathlib import Path

# Target a dedicated test directory
target_folder = input("Enter the target folder name: ")
current_path = Path.cwd() / target_folder
current_path.mkdir(parents=True, exist_ok=True)

# User input with integer conversion
num_of_files = int(input("Enter the number of folders you want to create: "))

# Create Parent files
parents = ["Activities", "Lectures", "Projects", "Resources"]
for parent in parents:
    folder = current_path / parent
    try:
        folder.mkdir(parents=True, exist_ok=False)
        print(f"Created: {folder.name} inside {current_path.name}")
    except FileExistsError:
        print("{folder} has already existed")

# Create children files
for i in range(1, num_of_files + 1):
    folder = current_path / "Activities" /  f"Week {i}"
    try:
        folder.mkdir(parents=True, exist_ok=False)
        print(f"Created: {folder.name} inside Activities ({i}/{num_of_files})")
    except FileExistsError:
        print(f"{folder} has already existed")

print("Done")

