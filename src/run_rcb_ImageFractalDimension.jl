from ImageFractalDimension import ImageFractalDimension

image_name = '../../../images/ecb_bw-n15-433x433mm-300dpi.png'
image_size = 512

image = ImageFractalDimension(image_name, image_size)
print(image.fractal_dim)
image.graph()

