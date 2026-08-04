# Code for LSSURP 2026 UMAP analysis project
## How to use:
1. Create `sd` of RRow session data using `TaskInit` (found in ADRLAB-codeset-master)
2. Input `sd` to `session_to_umap` to generate a `manifoldOutline` for the session
- `sd` & location (HC, LO, VO) are required inputs
- can change bin size (standard across neural data is 100 ms), dimensions (2), neighbors (100)
- can restrict session to certain timeframes
4. To generate UMAP plots, use `ManifoldPlot`
- can restrict to certain plot conditions (ie. time, offer delay, value) or just show all of them
5. To analyze plots, use `analysis` to obtain p values & graphs of distributions
## How the analysis works:
- For continuous variables:
  1. points from task/behavior data are sampled & shuffled
  2. pairwise distance/difference matrices are calculated
  3. regression analysis run to obtain R^2 values
  4. null distribution built
  5. real data is analyzed by distance/difference matrices & regression, then compared to null distribution
- For categorical variables:
  1. points from embedding are sampled & shuffled
  2. sum of variance is calculated for each category
  3. null distribution built
  4. real data is analyzed by sum of variances, then compared to null distribution
