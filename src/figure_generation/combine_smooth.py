from svgutils.compose import Figure, SVG, Text


languages = ["English", "Chinese", "Korean", "Spanish"]

for type in ["original", "winsorized"]:
    for base_model in [1, 11]:
        img_path = f"../../output/GAMMs/figures/smooth_{type}_base_model_{base_model}_plots/"

        num_cols = 4
        num_rows = 6
        width = 150
        height = 250
        filenames = []
        for model in [1, 3, 4, 6, 8, 9]:
            for language in ["E", "C", "K", "S"]:
                filenames.append(f"{img_path}{language}_{model}.svg")
        images = [SVG(filename).scale(0.21) for filename in filenames]
        start = (67 / 120) * width / num_cols
        texts = [Text(languages[i], font='Arial', x=start, y=34.5, size=3.5, anchor='middle') for i in range(num_cols)]

        figure = Figure(width, height, *texts, *images).tile(num_cols, num_rows + 1)
        figure.save(f'{img_path}grids/grid.svg')

        x = width - 2
        y = (height / 2) * (1 + 1 / (num_rows + 1))
        y_label = Text("Effect on Reading Time (ms)", x=x, y=y, anchor='middle', size=3.5).rotate(-90, x=x, y=y)
        image = SVG(f'{img_path}grids/grid.svg')
        figure2 = Figure(width * 2, height, y_label, image).tile(2, 1)

        figure2.save(f'{img_path}grids/lexical_grid.svg')

        num_rows = 3
        width = 150
        height = 141
        filenames = []
        for model in [2, 5, 7]:
            for language in ["E", "C", "K", "S"]:
                filenames.append(f"{img_path}{language}_{model}.svg")
        images = [SVG(filename).scale(0.21) for filename in filenames]
        start = (67 / 120) * width / num_cols
        texts = [Text(languages[i], font='Arial', x=start, y=34.5, size=3.5, anchor='middle') for i in range(num_cols)]

        figure = Figure(width, height, *texts, *images).tile(num_cols, num_rows + 1)
        figure.save(f'{img_path}grids/grid.svg')

        x = width - 2
        y = (height / 2) * (1 + 1 / (num_rows + 1))
        y_label = Text("Effect on Reading Time (ms)", x=x, y=y, anchor='middle', size=3.5).rotate(-90, x=x, y=y)
        image = SVG(f'{img_path}grids/grid.svg')
        figure2 = Figure(width * 2, height, y_label, image).tile(2, 1)

        figure2.save(f'{img_path}grids/syntactic_grid.svg')
