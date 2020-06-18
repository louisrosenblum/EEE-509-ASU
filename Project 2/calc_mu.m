results = []
mus = []

for i = 1:100
    mu = rand(1,1) * 0.15;
    project2;
    results = [results diff];
    mus = [mus mu];
end

[M,I] = max(results);

Max_diff = M

Max_mu = mus(I)