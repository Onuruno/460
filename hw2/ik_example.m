d = 2.5;
line_trajectory = [-2 3 0.5 4];
%samples = 2;
samples = 6;
%samples = 10;
%animation would be too slow after this point! Try plotting by other means
%sample = 100;
%sample = 1000;
%%
solns = ik_2link_arm(d, 1, 1)
%%
[theta_1s, theta_2s] = line_ik_2link_arm(d,line_trajectory, samples)
%%
animate_line_ik_2link_arm(d,theta_1s, theta_2s, line_trajectory)
%%
samples = 2;
[theta_1s, theta_2s] = line_ik_2link_arm(d,line_trajectory, samples)
%%
animate_line_ik_2link_arm(d,theta_1s, theta_2s, line_trajectory)
%%
samples=10;
[theta_1s, theta_2s] = line_ik_2link_arm(d,line_trajectory, samples)
%%
animate_line_ik_2link_arm(d,theta_1s, theta_2s, line_trajectory)
%%

%%  3- The reason as the robot fully extends, the error seems to increase is that
%% when the angle theta_2 is smaller end effector's velocity is bigger since
%% angular velocity of theta_1 is constant and the distance between origin and
%% end effector is longer.

%%  4- 









