#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Simple K-means implementation for 2D points.
// Usage: compile and run; optional argument: k (default 2)

typedef struct { double x, y; } Point;

static Point data[] = {
    {1.0, 2.0}, {1.5, 1.8}, {5.0, 8.0}, {8.0, 8.0}, {1.0, 0.6},
    {9.0, 11.0}, {8.0, 2.0}, {10.0, 2.0}, {9.0, 3.0}, {10.5, 3.5}
};
static const int N = sizeof(data)/sizeof(data[0]);

static double dist(Point a, Point b) { return sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y)); }

int main(int argc, char **argv) {
    int k = 2;
    if (argc >= 2) k = atoi(argv[1]);
    if (k <= 0 || k > N) {
        printf("Invalid k (must be 1..%d)\n", N);
        return 1;
    }

    Point *centroids = malloc(sizeof(Point)*k);
    int *assign = malloc(sizeof(int)*N);
    if (!centroids || !assign) return 2;

    // initialize centroids deterministically: take first k points
    for (int i=0;i<k;i++) centroids[i] = data[i];

    int changed = 1, iterations = 0, max_iter = 100;
    while (changed && iterations < max_iter) {
        changed = 0;
        iterations++;
        // assignment step
        for (int i=0;i<N;i++) {
            double bestd = 1e300; int best = -1;
            for (int j=0;j<k;j++) {
                double d = dist(data[i], centroids[j]);
                if (d < bestd) { bestd = d; best = j; }
            }
            if (assign[i] != best) { changed = 1; assign[i] = best; }
        }
        // update step: recompute centroids as mean of assigned points
        for (int j=0;j<k;j++) {
            double sx=0, sy=0; int cnt=0;
            for (int i=0;i<N;i++) if (assign[i]==j) { sx += data[i].x; sy += data[i].y; cnt++; }
            if (cnt>0) { centroids[j].x = sx/cnt; centroids[j].y = sy/cnt; }
        }
    }

    printf("K-means finished in %d iterations (k=%d)\n", iterations, k);
    for (int j=0;j<k;j++) printf("Centroid %d: (%.3f, %.3f)\n", j, centroids[j].x, centroids[j].y);
    printf("Assignments:\n");
    for (int i=0;i<N;i++) printf(" point %2d (%.2f,%.2f) -> cluster %d\n", i, data[i].x, data[i].y, assign[i]);

    free(centroids); free(assign);
    return 0;
}
