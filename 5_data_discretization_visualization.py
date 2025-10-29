import matplotlib.pyplot as plt
import numpy as np

# Sample data (individual observations)
data = [
    1, 1, 4, 4, 4, 7, 7, 9, 9, 9, 11, 13, 13, 13,
    17, 17, 17, 17, 17, 21, 21, 25, 25, 25, 25, 25, 28, 28, 30, 30,
]

fig, axs = plt.subplots(1, 2, figsize=(14, 5))

# Left: bar chart showing each unique value and its frequency
unique_vals, counts = np.unique(data, return_counts=True)
bar_width = 0.7
axs[0].bar(unique_vals, counts, width=bar_width, edgecolor='black', color='skyblue')
axs[0].set_title("Histogram with Individual Values as Buckets")
axs[0].set_xlabel("Value")
axs[0].set_ylabel("Frequency")
axs[0].set_xticks(unique_vals)

# Right: equal-width histogram (bins specified)
bins = [0, 10, 20, 30]
counts_hist, _ = np.histogram(data, bins=bins)
# compute centers of the bins for a bar plot
bin_centers = [(bins[i] + bins[i+1]) / 2 for i in range(len(bins) - 1)]
axs[1].bar(bin_centers, counts_hist, width=7, edgecolor='black', align='center', color='salmon')
axs[1].set_title("Equal-width Histogram (Width = 10)")
axs[1].set_xlabel("Ranges")
axs[1].set_ylabel("Frequency")
axs[1].set_xticks(bins)

plt.tight_layout()

if __name__ == '__main__':
    plt.show()
