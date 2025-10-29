

from itertools import combinations

# transactions from your attachment; each transaction is a set
transactions = [set(t) for t in [
    ['1', '3', '4'],
    ['2', '3', '5'],
    ['1', '2', '3', '5'],
    ['2', '5'],
    ['1', '3', '5'],
]]

min_support = 2
min_confidence = 0.6


def get_support(itemset):
    return sum(1 for t in transactions if itemset.issubset(t))


def apriori(min_support):
    # initial set of 1-item candidates
    freq_sets = {frozenset([item]) for t in transactions for item in t}
    # filter by min_support
    freq_sets = {item for item in freq_sets if get_support(item) >= min_support}
    all_freq_sets = set(freq_sets)

    k = 2
    while freq_sets:
        # generate k-item candidates by union of previous frequent sets
        candidates = {frozenset(a | b) for a in freq_sets for b in freq_sets if len(a | b) == k}
        # keep those that meet min_support
        freq_sets = {c for c in candidates if get_support(c) >= min_support}
        all_freq_sets |= freq_sets
        k += 1

    return all_freq_sets


def generate_rules(freq_sets, min_confidence):
    rules = []
    for itemset in freq_sets:
        if len(itemset) > 1:
            for i in range(1, len(itemset)):
                for antecedent in combinations(itemset, i):
                    antecedent = frozenset(antecedent)
                    consequent = itemset - antecedent
                    conf = get_support(itemset) / get_support(antecedent)
                    if conf >= min_confidence:
                        rules.append((set(antecedent), set(consequent), conf))
    return rules


if __name__ == '__main__':
    freq_itemsets = apriori(min_support)
    print("Frequent Itemsets:")
    for itemset in sorted(freq_itemsets, key=lambda s: (len(s), sorted(list(s)))):
        print(f"{set(itemset)} support: {get_support(itemset)}")

    print("\nStrong Association Rules:")
    for antecedent, consequent, confidence in generate_rules(freq_itemsets, min_confidence):
        print(f"{set(antecedent)} -> {set(consequent)} (Confidence: {confidence*100:.2f}%)")
