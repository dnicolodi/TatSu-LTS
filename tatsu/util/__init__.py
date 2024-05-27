from ._common import *  # noqa: F403
from .asjson import *  # noqa: F403

if sys.version_info < (3, 10):
    import builtins

    def zip(*iterables, strict=False):
        return builtins.zip(*iterables)
else:
    zip = zip
