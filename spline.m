x = [1 3 5 7 9];
y = [2 1 4 3 1];
deltax = @(i) x(i+1) - x(i);
deltay = @(i) y(i+1) - y(i);
prime = @(i) deltay(i)/deltax(i);

a = [1 .5 0 0 0; 0 0 0 .5 1; deltax(2) 2*(deltax(1)+deltax(2)) ...
    deltax(1) 0 0; 0 deltax(3) 2*(deltax(2)+deltax(3)) deltax(2) 0; ...
    0 0 deltax(4) 2*(deltax(3)+deltax(4)) deltax(3)];
b = [(3/2)*prime(1); (3/2)*prime(4); ...
    3*(deltax(2)*prime(1) + deltax(1)*prime(2)); ...
    3*(deltax(3)*prime(2) + deltax(2)*prime(3)); ...
    3*(deltax(4)*prime(3) + deltax(3)*prime(4))];

s = b\a;

prime2 = @(i) (prime(i)-s(i))/(deltax(i));
prime3 = @(i) (s(i)-2*prime(i)+s(i+1))/(deltax(i)^2);

n = length(x);

inner_points = 100;
figure();
scatter(x, y, 'r');
hold on;
for i=1:n-1
    x0 = linspace(x(i),x(i+1),inner_points);
    p = y(i) + s(i).*(x0-x(i)) + prime2(i).*(x0-x(i)).^2 ...
    + prime3(i).*((x0 - x(i)).^2).*(x0-x(i+1));
    plot(x0,p,'b--');
end
ylim([0, 5]);
xlim([0, 10]);

