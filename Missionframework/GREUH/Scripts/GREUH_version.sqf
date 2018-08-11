GREUH_version = 1.2;

private _getRandomColor = {
	private _str = "#";
	private _mColors = ["ff","20","40","80","B0"];
	for [{_i=0}, {_i<3}, {_i=_i+1}] do
	{
		_str = _str + selectRandom _mColors;
	};
_str;
};

player createDiarySubject ["GREUH Options","GREUH Options"];
player createDiaryRecord ["GREUH Options", ["GREUH Options", format ["<font color='#ff8000'>GREUH Extended Options</font><br/>arma.greuh.org<br/><br/><font color='#ff8000'>Scripted by [GREUH] Zbug</font><br/>Version %1",GREUH_version]]];
player createDiarySubject ["SF Info","SF Info"];
player createDiarySubject ["SF Info", "SF Tweaks"];
player createDiaryRecord ["SF Info", ["SF Tweaks", format ["This version was build on %1 at %2, in The Midwest (United States)", GRLIB_build_date, GRLIB_build_time]]];
player createDiaryRecord ["SF Info", ["SF Tweaks", format ["Scripting Integration<br/>by <font color='#0080ff'>-SturmFalke101-</font>"]]];
player createDiaryRecord ["SF Info", ["SF Tweaks", format ["A3W Missions v1.3<br/>by <font color='%1'>-AgentRev-</font>", call _getRandomColor]]];

player createDiarySubject ["Player Help", "Ballistics"];
player createDiaryRecord ["Player Help", ["Ballistics", format ["Target distance in mils<br/><br/>
ARMA III - LiberationSFX<br/>
<img image='res\liberation.jpg' height='128' width='256'/><br/>
<font color='#0080ff'>http://8541tactical.com/range_estimation.php</font><br/><br/>
Mil-Dot<br/><font color='#0080ff'>Range Estimating</font><br/>
Range estimation requires common knowledge/experience about your target's actual width or height.<br/>
For accurate range estimating, the size of the target must be known.<br/>
1 mil in a scope reticle is the distance from the center of one dot to the center of the next dot.<br/>
Focal Planes <br/><font color='#0080ff'>First Focal Plane vs. Second Focal Plane</font><br/>
If the reticle grows and shrinks with magnification it is a First Focal Plane optic.<br/>
IF the reticle remains the same, it is one of the more common Second Focal Plane optics.<br/>
Second Focal Plane optics have a two problems: The first being that the reticle will only be accurate for ranging at one power setting.<br/>
The second is that the reticle will only be correct for holds at one power setting.<br/><br/>
Further, Army Mildots differ from USMC Football Mildots.<br/>
A whole Army mildot (think Leupold) is 0.2 mil in size, 0.8 mil from edge to edge, 1 mil from center to center, and 0.1mil in half.<br/>
A whole USMC Mildot is 0.25 mil in size, 0.75 mil from edge to edge, and 1 mil from center to center.<br/>
"]]];
player createDiaryRecord ["Player Help", ["Ballistics", format ["(Target Height in yards)<br/>x 1000 / Height in Mils <font color='%1'>-Range to Target in Yards-</font>", call _getRandomColor]]];
player createDiaryRecord ["Player Help", ["Ballistics", format ["(Target Height in inches)<br/>x 25.4 / Height in Mils <font color='%1'>-Range to Target in Meters-</font>", call _getRandomColor]]];
player createDiaryRecord ["Player Help", ["Ballistics", format ["(Target Height in meters)<br/>x 1000 / Height in Mils <font color='%1'>-Range to Target in Meters-</font>", call _getRandomColor]]];
player createDiaryRecord ["Player Help", ["Ballistics", format ["(Target Height in CM)<br/>x 10 / Height in Mils <font color='%1'>-Range to Target in Meters-</font>", call _getRandomColor]]];
