function example_3c()

    c_ref = 0.1;
    u_ref = 70.0;
    W = 10.0;
    T = 0.1;
    C = c_ref * (2 * W + 2 * T) / (T * W);
    K = 0.001;

    p_func = @(x) 0;
    q_func = @(x) -C / K;
    r_func = @(x) -K * C * u_ref;

    ns = [10, 50, 100];

    a = 0.0;
    b = 1.0;

    bound_condition_a.condition_type = "value";
    bound_condition_a.constants = [0.0];

    bound_condition_b.condition_type = "mixed";
    bound_condition_b.constants = [K, c_ref, c_ref * u_ref];

    output_dir = "out/example_3c";

    for i = 1 : numel(ns)
        [x, u] = bvp1d(a, b, ns(i), p_func, q_func, r_func, bound_condition_a, bound_condition_b);
        hf = figure();
        plot(x, u);
        title(sprintf("Resfriador Unidimensional (c_ref = %e, n = %d)", c_ref, ns(i)));
        print(hf, sprintf("%s/n_%d.png", output_dir, ns(i)), "-dpng");
    end

end