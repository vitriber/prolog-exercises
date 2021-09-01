heavy_operation.

:- statistics(walltime, [_TimeSinceStart | [_TimeSinceLastCall]]),
    heavy_operation, !,
    statistics(walltime, [_NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.
