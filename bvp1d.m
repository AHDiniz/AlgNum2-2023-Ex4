function [x, u, er] = bvp1d(a, b, n, p_func, q_func, r_func, bound_condition_a, bound_condition_b)

    er = 0;

    p = zeros(n, 1);
    q = zeros(n, 1);
    r = zeros(n, 1);

    x = linspace(a, b, n);
    x = x';

    for i = 1 : n
        p(i) = p_func(x(i));
        q(i) = q_func(x(i));
        r(i) = r_func(x(i));
    end

    h = (b - a) / (n - 1);

    A = zeros(n, n);
    f = zeros(n, 1);

    A(1, 1) = q(1) - (2 / (h * h));
    A(1, 2) = (1 / (h * h)) + p(1) / (2 * h);
    f(1) = r(1);
    for i = 2 : n - 1
        A(i, i - 1) = (1 / (h * h)) - p(i) / (2 * h);
        A(i, i)     = q(i) - (2 / (h * h));
        A(i, i + 1) = (1 / (h * h)) + p(i) / (2 * h);
        f(i) = r(i);
    end
    A(n, n - 1) = (1 / (h * h)) - p(n) / (2 * h);
    A(n, n)     = q(n) - (2 / (h * h));
    f(n) = r(n);

    b_1 = (1 / (h * h)) - p(1) / (2 * h);
    switch bound_condition_a.condition_type
        case "value"
            A(1, 1) = 1;
            A(1, 2) = 0;
            f(1) = bound_condition_a.constants(1);
        case "derivative"
            A(1, 1) += b_1;
            f(1) += b_1 * h * bound_condition_a.constants(1);
        case "mixed"
            A(1, 1) += b_1 * (1 + h * bound_condition_a.constants(2) / bound_condition_a.constants(1));
            f(1) += b_1 * (h * bound_condition_a.constants(3) / bound_condition_a.constants(1));
        otherwise
            u = zeros(n, 1);
            er = 1;
            return;
    end

    c_n = (1 / (h * h)) + p(n) / (2 * h);
    switch bound_condition_b.condition_type
        case "value"
            A(n, n) = 1;
            A(n, n - 1) = 0;
            f(n) = bound_condition_b.constants(1);
        case "derivative"
            A(n, n) += c_n;
            f(n) -= c_n * h * bound_condition_b.constants(1);
        case "mixed"
            A(n, n) += c_n * (1 - h * bound_condition_b.constants(2) / bound_condition_b.constants(1));
            f(n) -= c_n * (h * bound_condition_b.constants(3) / bound_condition_b.constants(1));
        otherwise
            u = zeros(n, 1);
            er = 1;
            return;
    end

    u = A \ f;

end