
# https://stackoverflow.com/questions/72723928/how-to-combine-several-images-to-one-image-in-a-grid-structure-in-python
from PIL import Image


def combine_images(columns, space, images, filename):
    rows = len(images) // columns
    if len(images) % columns:
        rows += 1
    width_max = max([Image.open(image).width for image in images])
    height_max = max([Image.open(image).height for image in images])
    background_width = width_max*columns + (space*columns)-space
    background_height = height_max*rows + (space*rows)-space
    background = Image.new('RGBA', (background_width, background_height), (255, 255, 255, 255))
    x = 0
    y = 0
    for i, image in enumerate(images):
        img = Image.open(image)
        x_offset = int((width_max-img.width)/2)
        y_offset = int((height_max-img.height)/2)
        background.paste(img, (x+x_offset, y+y_offset))
        x += width_max + space
        if (i+1) % columns == 0:
            y += height_max + space
            x = 0
    background.save(filename)

num_cols = 4

for type in ["original", "winsorized"]:
    for base_model in [1, 11]:
        img_path = f"../../output/GAMMs/figures/smooth_{type}_base_model_{base_model}_plots_with_residuals/"



        filenames = []
        for model in [1, 3, 4, 6, 8, 9]:
            for language in ["E", "C", "K", "S"]:
                filenames.append(f"{img_path}{language}_{model}.png")

        combine_images(columns=num_cols, space=20, images=filenames, filename=f'{img_path}grids/lexical_grid.png')

        filenames = []
        for model in [2, 5, 7]:
            for language in ["E", "C", "K", "S"]:
                filenames.append(f"{img_path}{language}_{model}.png")

        combine_images(columns=num_cols, space=20, images=filenames, filename=f'{img_path}grids/syntactic_grid.png')
