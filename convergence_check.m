function convergence_check(a, b, ns, p_func, q_func, r_func, bound_condition_a, bound_condition_b, solution, output_dir)

    results = cell(numel(ns));

    for i = 1 : numel(ns)
        n = ns(i);

        [x_i, u_i] = bvp1d(a, b, n, p_func, q_func, r_func, bound_condition_a, bound_condition_b);
        
        y_i = zeros(n, 1);
        for j = 1 : n
            y_i(j) = solution(x_i(j));
        end

        results{i} = [x_i, u_i, y_i];
        
        hf = figure();
        plot(x_i, y_i, "*", x_i, u_i);
        title(sprintf("Solução Aproximada n = %d", n));
        legend("Real", "Aproximada");
        print(hf, sprintf("%s/n_%d.png", output_dir, n), "-dpng");
    end

    space_length = b - a;
    logh = zeros(numel(ns), 1);
    logE = zeros(numel(ns), 1);
    for i = 1 : numel(ns)
        logh(i) = log(space_length / (ns(i) - 1));
        logE(i) = log(norm(results{i}(2) - results{i}(3), inf));
    end

    [p] = polyfit(logh, logE, 1);

    px = polyval(p, logh);

    hf = figure();
    plot(logh, logE, "o", logh, px);
    title("Taxa de Convergência 1D");
    print(hf, sprintf("%s/convergence.png", output_dir), "-dpng");

end