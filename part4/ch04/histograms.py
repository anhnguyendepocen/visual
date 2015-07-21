import numpy
import pylab

# Build a vector of 10000 normal deviates with variance 0.5^2 and mean 2
mu, sigma = 2, 0.5
v = numpy.random.normal(mu,sigma,10000)


# Compute the histogram with numpy and then plot it
(n, bins) = numpy.histogram(v, bins=50, normed=True)  # NumPy version (no plot)

def draw():
    pylab.plot(.5*(bins[1:]+bins[:-1]), n)
    pylab.show()
    # Plot a normalized histogram with 50 bins
    pylab.hist(v, bins=50, normed=1)       # matplotlib version (plot)
    pylab.show()


if __name__=="__main__":
    draw()


