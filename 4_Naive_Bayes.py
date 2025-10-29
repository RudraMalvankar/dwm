"""
Simple Naive Bayes
"""

data = {
    'Mango':  {'Yellow': 35, 'Sweet': 45, 'Long': 0,  'Total': 65},
    'Banana': {'Yellow': 40, 'Sweet': 30, 'Long': 35, 'Total': 40},
    'Orange': {'Yellow': 5,  'Sweet': 10, 'Long': 5,  'Total': 15},
}

# derive totals from the data so they can't get out of sync
total_fruits = sum(v['Total'] for v in data.values())
features = ['Yellow', 'Sweet', 'Long']

results = {}
for fruit, values in data.items():
    # Prior: P(fruit)
    prior = values['Total'] / total_fruits

    # Likelihood: product over features P(feature | fruit)
    likelihood = 1.0
    for feature in features:
        # estimate P(feature | fruit) = count(feature for fruit) / total_for_that_fruit
        # if a feature count is 0 this will make likelihood 0 (no smoothing here)
        likelihood *= values[feature] / values['Total']

    # Unnormalized posterior (Bayes numerator): prior * likelihood
    posterior = prior * likelihood
    results[fruit] = posterior

# Normalize to get probabilities that sum to 1 (unless all posteriors are zero)
total_posterior = sum(results.values())

print("Probabilities of Fruits:")
for fruit, posterior in results.items():
    prob = (posterior / total_posterior) if total_posterior > 0 else 0
    print(f"{fruit}: {prob:.2f}")

# predicted fruit (highest unnormalized posterior is same as highest normalized)
predicted_fruit = max(results, key=results.get)
print(f"\nPredicted Fruit: {predicted_fruit}")
