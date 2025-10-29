#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Simple K-medoids (PAM-like) implementation for 2D points.
// Usage: compile and run; optional argument: k (default 2)

typedef struct { double x, y; } Point;

static Point data[] = {
    {1.0, 2.0}, {1.5, 1.8}, {5.0, 8.0}, {8.0, 8.0}, {1.0, 0.6},
    {9.0, 11.0}, {8.0, 2.0}, {10.0, 2.0}, {9.0, 3.0}, {10.5, 3.5}
};
static const int N = sizeof(data)/sizeof(data[0]);

static double dist(Point a, Point b) { return sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y)); }

int contains(int *arr, int len, int val) { for (int i=0;i<len;i++) if (arr[i]==val) return 1; return 0; }

int main(int argc, char **argv) {
    int k = 2;
    if (argc >= 2) k = atoi(argv[1]);
    if (k <= 0 || k > N) {
        printf("Invalid k (must be 1..%d)\n", N);
        return 1;
    }

    int *medoids = malloc(sizeof(int)*k);
    int *assign = malloc(sizeof(int)*N);
    if (!medoids || !assign) return 2;

    // initialize medoids deterministically: first k points indices
    for (int i=0;i<k;i++) medoids[i] = i;

    int changed = 1, iterations = 0, max_iter = 100;
    while (changed && iterations < max_iter) {
        changed = 0; iterations++;
        // assignment step
        for (int i=0;i<N;i++) {
            double bestd = 1e300; int best = -1;
            for (int j=0;j<k;j++) {
                double d = dist(data[i], data[medoids[j]]);
                if (d < bestd) { bestd = d; best = j; }
            }
            assign[i] = best;
        }
        // update step (for each cluster, pick the medoid that minimizes total distance)
        for (int j=0;j<k;j++) {
            // collect indices in cluster j
            int cluster_count = 0;
            for (int i=0;i<N;i++) if (assign[i]==j) cluster_count++;
            if (cluster_count==0) continue;
            int *cluster_idx = malloc(sizeof(int)*cluster_count);
            int idx=0; for (int i=0;i<N;i++) if (assign[i]==j) cluster_idx[idx++]=i;

            double best_cost = 1e300; int best_medoid = medoids[j];
            for (int a=0;a<cluster_count;a++) {
                int cand = cluster_idx[a];
                double cost = 0.0;
                for (int b=0;b<cluster_count;b++) cost += dist(data[cand], data[cluster_idx[b]]);
                if (cost < best_cost) { best_cost = cost; best_medoid = cand; }
            }
            if (best_medoid != medoids[j]) { medoids[j] = best_medoid; changed = 1; }
            free(cluster_idx);
        }
    }

    printf("K-medoids finished in %d iterations (k=%d)\n", iterations, k);
    for (int j=0;j<k;j++) printf("Medoid %d: index %d (%.3f, %.3f)\n", j, medoids[j], data[medoids[j]].x, data[medoids[j]].y);
    printf("Assignments:\n");
    for (int i=0;i<N;i++) printf(" point %2d (%.2f,%.2f) -> cluster %d\n", i, data[i].x, data[i].y, assign[i]);

    free(medoids); free(assign);
    return 0;
}
