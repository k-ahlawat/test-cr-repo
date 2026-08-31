"""Print command-line arguments back to standard output."""

import sys


def main() -> None:
    """Echo command-line arguments separated by spaces."""
    print(" ".join(sys.argv[1:]))


if __name__ == "__main__":
    main()
