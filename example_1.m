function example_1()

    p_func = @(x) x;
    q_func = @(x) 1;
    r_func = @(x) 4 * x * x * x + 4 * x + 1;
    solution = @(x) x * x * x - x + 1;

    ns = [16, 24, 32, 48, 64];

    a = 0.0;
    b = 1.0;

    bound_condition_a.condition_type = "value";
    bound_condition_a.constants = [1.0];

    bound_condition_b.condition_type = "mixed";
    bound_condition_b.constants = [2.0, 1.0, 5.0];

    output_dir = "out/example_1";

    convergence_check(a, b, ns, p_func, q_func, r_func, bound_condition_a, bound_condition_b, solution, output_dir);

end