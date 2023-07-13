from svgutils.compose import Figure, SVG, Text


img_path = "/output/GAMMs/images/AIC_plots/"
num_cols = 2
num_rows = 2
width =182
height = 225
images = [SVG(f"{img_path}{language}_AIC.svg").scale(0.21) for language in ["E", "C", "K", "S"]]


figure = Figure(width, height, *images).tile(num_cols, num_rows+1)
figure.save(f'{img_path}AIC_grid.svg')

img_path = "/output/GAMMs/images/BIC_plots/"
images = [SVG(f"{img_path}{language}_BIC.svg").scale(0.21) for language in ["E", "C", "K", "S"]]


figure = Figure(width, height, *images).tile(num_cols, num_rows+1)
figure.save(f'{img_path}BIC_grid.svg')

img_path = "/output/GAMMs/images/logLik_plots/"
images = [SVG(f"{img_path}{language}_logLik.svg").scale(0.21) for language in ["E", "C", "K", "S"]]


figure = Figure(width, height, *images).tile(num_cols, num_rows+1)
figure.save(f'{img_path}logLik_grid.svg')