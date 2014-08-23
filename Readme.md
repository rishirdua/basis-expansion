Non Linear Basis Expansion
==========================
Generates features according to different non-linear basis expansion methods

Currently implemented methods:

- Expands each feature I with 1 <= I <= n_features as a vector of n features as exp(-\gamma x_i^2) .* [1, z, (z^2)/sqrt(2!), (z^3)/sqrt(3!) , …, (z^n)/sqrt(n!)] where z= \sqrt(2*\gamma) x_i.
ie. For any given n you will now get a vector of size n_features*(n+1). Given a value for n, repeats for k = 1, 2, 3, ... n

- Recht and Rahimi’s Random Fourier Features as defined in
Rahimi, Ali, and Benjamin Recht. "Random features for large-scale kernel machines." In Advances in neural information processing systems, pp. 1177-1184. 2007.

Author
------
Rishi Dua <http://github.com/rishirdua>


Contribute
----------
Todo: Implementing other basis: Gaussian, Polynomial etc.

- Issue Tracker: https://github.com/rishirdua/basis-expansion/
- Source Code: github.com/rishirdua/basis-expansion
- Project page: http://rishirdua.github.io/basis-expansion


License
-------
This project is licensed under the terms of the MIT license. See LICENCE.txt for details