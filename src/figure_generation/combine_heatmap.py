from svgutils.compose import Figure, SVG, Text


img_path = "../../output/GAMMs/term_significance/"
num_cols = 2
num_rows = 2
width =150
height = 265
images = [SVG(f"{img_path}{language}_heatmap.svg").scale(0.3) for language in ["E", "C", "K", "S"]]


figure = Figure(width, height, *images).tile(num_cols, num_rows+1)
figure.save(f'{img_path}heatmap_grid.svg')

# img_path = "/output/GAMMs/images/BIC_plots/"
# images = [SVG(f"{img_path}{language}_BIC.svg").scale(0.21) for language in ["E", "C", "K", "S"]]
#
#
# figure = Figure(width, height, *images).tile(num_cols, num_rows+1)
# figure.save(f'{img_path}BIC_grid.svg')
#
# img_path = "/output/GAMMs/images/logLik_plots/"
# images = [SVG(f"{img_path}{language}_logLik.svg").scale(0.21) for language in ["E", "C", "K", "S"]]
#
#
# figure = Figure(width, height, *images).tile(num_cols, num_rows+1)
# figure.save(f'{img_path}logLik_grid.svg')