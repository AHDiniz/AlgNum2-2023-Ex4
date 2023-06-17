function example_2b()

    p_func = @(x) 0;
    q_func = @(x) 0.01;
    r_func = @(x) -0.01 * 20.0;

    ns = [10, 50, 100];

    a = 0.0;
    b = 10.0;

    bound_condition_a.condition_type = "value";
    bound_condition_a.constants = [40.0];

    bound_condition_b.condition_type = "derivative";
    bound_condition_b.constants = [0.0];

    output_dir = "out/example_2b";

    for i = 1 : numel(ns)
        [x, u] = bvp1d(a, b, ns(i), p_func, q_func, r_func, bound_condition_a, bound_condition_b);
        hf = figure();
        plot(x, u);
        title(sprintf("Conservação de Calor - Fluxo Prescrito (n = %d)", ns(i)));
        print(hf, sprintf("%s/n_%d.png", output_dir, ns(i)), "-dpng");
    end

end