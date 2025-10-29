import numpy as np
import matplotlib.pyplot as plt

try:
    from scipy.cluster.hierarchy import dendrogram, linkage
except Exception as e:
    raise ImportError("scipy.cluster.hierarchy could not be imported; please install scipy (e.g. run: python -m pip install scipy)") from e

X = np.array([[2, 2],
              [3, 2],
              [1, 1],
              [3, 1],
              [1.5, 0.5]])

labels = ['A', 'B', 'C', 'D', 'E']

Z = linkage(X, method='single')

plt.figure(figsize=(8, 5))
dendrogram(Z, labels=labels)
plt.title('Single Linkage Hierarchical Clustering')
plt.xlabel('Objects')
plt.ylabel('Distance')
plt.grid(True)
plt.show()
# python -m pip install --upgrade pip
# python -m pip install numpy matplotlib scipy