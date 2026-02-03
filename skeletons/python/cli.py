"""${filename} CLI."""

import argparse
import logging

logger = logging.getLogger(__name__)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="${filename}")
    parser.add_argument("path", help="Path to input")
    return parser.parse_args()


def main() -> int:
    logging.basicConfig(level=logging.INFO)
    args = parse_args()
    logger.info("Running with %s", args.path)
    ${cursor}
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
