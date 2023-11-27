#!/usr/bin/env python3

class Grid:
    def __init__(self, M, N):
        self.N = N
        self.M = M
        self.grid = [[0 for _ in range(M+N-1)] for _ in range(M+N-1)]

    def check_bounds(self, x, y):
        return 1 <= x <= self.M+self.N-1 and\
            1 <= y <= self.M+self.N-1 and\
            self.M+1 <= x+y <= 2*self.M + self.N - 1

    def get(self, x, y):
        if not self.check_bounds(x, y):
            return 0
        return self.grid[x-1][y-1]

    def select(self, x, y):
        assert self.check_bounds(x, y)
        self.grid[x-1][y-1] = 1

    def grid_parity(self):
        for x in range(1, self.M+self.N):
            nums = [self.get(x, y) for y in range(1, self.N + self.M)]
            if sum(nums) % 2 != 1:
                print(f"Found a contradiction at x={x}! {nums}")
                return False
        for y in range(1, self.M+self.N):
            nums = [self.get(x, y) for x in range(1, self.N + self.M)]
            if sum(nums) % 2 != 1:
                print(f"Found a contradiction at y={y}! {nums}")
                return False
        for s in range(self.M+1, 2*self.M+self.N):
            nums = [self.get(x, s-x) for x in range(1, s)]
            if sum(nums) % 2 != 1:
                print(f"Found a contradiction at x+y={s}! {nums}")
                return False
        return True

    def reflect(self):
        res = [[0 for _ in range(len(self.grid[i]))]
               for i in range(len(self.grid))]
        for x in range(self.M+self.N-1):
            # reflect across x + y = m + n - 2
            for y in range(self.M+self.N-1):
                sm = 2 * (self.M+self.N-2) - (x+y)
                diff = x - y
                res[(sm + diff)//2][(sm - diff)//2] = self.grid[x][y]
        self.grid = res
        tmp = self.M
        self.M = self.N
        self.N = tmp

    def plot(self, save_path):
        from matplotlib import pyplot as plt
        import numpy
        plt.clf()
        fig = plt.figure()
        ax = fig.gca()
        ax.set_xticks(numpy.arange(1, self.M+self.N, 1))
        ax.set_yticks(numpy.arange(1, self.M+self.N, 1))
        ax.set_aspect("equal")

        ax.set_xbound(0, self.M+self.N)
        ax.set_ybound(0, self.M+self.N)
        ax.autoscale(enable=False)
        x = []
        y = []
        for i in range(1, self.M+self.N):
            for j in range(1, self.M+self.N):
                if self.get(i, j):
                    x.append(i)
                    y.append(j)
        plt.scatter(x, y, color='b')
        plt.title(f"Construction for M={self.M}, N={self.N}")

        plt.plot([1, self.M], [self.M, 1], color='r')
        plt.plot([self.M, self.N+self.M-1],
                 [self.N+self.M-1, self.M], color='r')
        plt.plot([1, 1, self.M], [self.M, self.M +
                 self.N-1, self.M+self.N-1], color='r')
        plt.plot([self.M, self.M+self.N-1, self.M+self.N-1],
                 [1, 1, self.M], color='r')
        plt.grid()

        plt.savefig(save_path)


def one(M, N) -> Grid:
    assert (N-M) % 4 == 0
    assert M == 1 or N == 1
    reflect = M == 1
    if reflect:
        tmp = M
        M = N
        N = tmp
    g = Grid(M, N)
    for k in range(1, M+1):
        g.select(k, M+1-k)

    for k in range(1, M//2+1):
        g.select((M+1)//2, (M+1)//2+k)
        g.select(M, (M+1)//2+k)

    if reflect:
        g.reflect()
    return g


def cong_mod4(M, N) -> Grid:
    assert (N-M) % 4 == 0 and N != 1 and M != 1
    reflect = M > N
    if reflect:
        tmp = M
        M = N
        N = tmp
    g = Grid(M, N)

    if M % 2 == 1:
        g.select(M, M)

    # Main Axis points
    for k in range(1, N//2+1):
        g.select(M, M+2*k-1)
    for k in range(1, (M-1)//2+1):
        g.select(M, M-2*k)

    for k in range(1, (N-1)//2+1):
        g.select(M+2*k, M)
    for k in range(1, M//2+1):
        g.select(M-2*k+1, M)

    # Points on the diagonal
    for k in range(1, M//2 + 1):
        g.select(M+2*k-1, M-2*k+1)  # going down
    for k in range(1, (M-1)//2+1):
        g.select(M-2*k, M+2*k)  # going up

    for k in range(1, (N-M)//2+1):
        g.select(
            M+2*(M//2) - 1 + 2*k,
            M-2*(M//2) + 2,
        )
        g.select(
            M - 2*((M-1)//2) + 1,
            M + 2*((M-1)//2) + 2*k,
        )
    if reflect:
        g.reflect()
    return g


def mod_0_1(M, N):
    assert (M+N) % 4 == 1 and M % 4 in [0, 1]
    reflect = (M % 4) == 1
    if reflect:
        tmp = M
        M = N
        N = tmp
    g = Grid(M, N)

    g.select(M, M)
    # Main Axis Points
    for k in range(1, N//2+1):
        g.select(M, M+2*k-1)
    for k in range(1, (M-1)//2+1):
        g.select(M, M-2*k)

    for k in range(1, (N-1)//2+1):
        g.select(M+2*k, M)
    for k in range(1, M//2+1):
        g.select(M-2*k+1, M)
    # Step 3
    for k in range(0, M//2):
        g.select(M-2*k, 1+2*k)

    # Tail
    for k in range(1, (N-1)//2+1):
        g.select(2, M+2*k)
        g.select(M+2*k-1, 3)

    if reflect:
        g.reflect()
    return g


def mod_2_3(M, N):
    assert (M+N) % 4 == 1 and M % 4 in [2, 3]
    reflect = (M % 4) == 2
    if reflect:
        tmp = M
        M = N
        N = tmp
    g = Grid(M, N)

    for k in range(1, M+1):
        g.select(k, M+1-k)

    for k in range((M+1)//2+1, M+1):
        g.select((M+1)//2, k)
        g.select(M+1, k)
    g.select((M+1)//2, M+1)

    for k in range(1, (N-2)//2 + 1):
        g.select(M+1, M+2*k)
        g.select(M+2*k, M)

        g.select(1, M+1+2*k)
        g.select(M+1+2*k, 1)

    if reflect:
        g.reflect()
    return g


def construct(M, N) -> 'Grid | None':
    if (M-N) % 4 == 0:
        if M != 1 and N != 1:
            return cong_mod4(M, N)
        else:
            return one(M, N)
    elif (M+N) % 4 == 1:
        if (M % 4) in [0, 1]:
            return mod_0_1(M, N)
        else:
            return mod_2_3(M, N)
    else:
        assert ((N+M-1)*(N-M)) % 4 == 2
        return None


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("usamts_checker.py")
    parser.add_argument("m",  type=int, help='m (first integer)')
    parser.add_argument("n",  type=int, help='n (second integer)')
    parser.add_argument("--output",
                        "-o",
                        required=False,
                        default=None,
                        type=str,
                        help="File in which to output plotted image")
    args = parser.parse_args()
    M: int = args.m
    N: int = args.n

    g = construct(M, N)
    if g is None:
        print("No solution is possible!")
    else:
        if args.output:
            g.plot(args.output)
        assert g.grid_parity()