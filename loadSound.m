function [bomb,gun,fight,bombFs,gunFs,fightFs,fail,failFS,win,winFS]=loadSound()
[bomb,bombFs] = audioread('soundbomb.wav');
bomb=bomb(1:6*bombFs);
bomb = 10 * bomb;

[gun,gunFs] = audioread('MP5_gun.wav');
gun=gun(1:gunFs);

[fight,fightFs] = audioread('soundfight.wav');
fight=fight(1:20*fightFs);

[fail,failFS]= audioread('soundfail.mp3');
fail=fail(1:failFS);
fail= 10 *fail;

[win,winFS]=audioread('soundwin.mp3');
win=win(1:winFS);
win=win*10;
% [tank,tankFs] = audioread('Tank.wav');
% fight=fight(1:20*tankFs);
