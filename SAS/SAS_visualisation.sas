proc sql;
	create view res_vs_rsa as 
	select year as year, AVG(residual_demand) as residual ,AVG(rsa_contracted_demand) as rsa_residual from WORK.DEMAND group by year order by year;
run;

proc sgplot data=WORK.res_vs_rsa;
	title Average residual vs rsa contracted demand;
	series x=year y=residual;
	series x=year y=rsa_residual;
	yaxis label="Energy in GW";

proc sql;
    create view year_count as
    select year as year ,count(case when stage = 1 then 1 end) as stage_1,count(case when stage = 2 then 1 end) as stage_2,count(case when stage = 3 then 1 end) as stage_3,count(case when stage = 4 then 1 end) as stage_4,count(case when stage = 5 then 1 end) as stage_5,count(case when stage = 6 then 1 end) as stage_6 FROM WORK.LOADSHEDDING GROUP BY year ORDER by year;
run;

proc sgplot data=WORK.YEAR_COUNT;
    title Year vs Stage count;
    series x=year y=stage_1;
    series x=year y=stage_2;
    series x=year y=stage_3;
    series x=year y=stage_4;
    series x=year y=stage_5;
    series x=year y=stage_6;
    yaxis label="stage count";
run;
proc sql;
    create view month_count as
    select month_name as month_name,month as month ,count(case when stage = 1 then 1 end) as stage_1,count(case when stage = 2 then 1 end) as stage_2,count(case when stage = 3 then 1 end) as stage_3,count(case when stage = 4 then 1 end) as stage_4,count(case when stage = 5 then 1 end) as stage_5,count(case when stage = 6 then 1 end) as stage_6 FROM WORK.LOADSHEDDING GROUP BY month_name ORDER by month;
run;

proc sgplot data=WORK.MONTH_COUNT;
    title Month vs Stage count;
    series x=month_name y=stage_1;
    series x=month_name y=stage_2;
    series x=month_name y=stage_3;
    series x=month_name y=stage_4;
    series x=month_name y=stage_5;
    series x=month_name y=stage_6;
    yaxis label="stage count";
run;
proc sql;
    create view day_count as
    select day_name as day_name,day as day ,count(case when stage = 1 then 1 end) as stage_1,count(case when stage = 2 then 1 end) as stage_2,count(case when stage = 3 then 1 end) as stage_3,count(case when stage = 4 then 1 end) as stage_4,count(case when stage = 5 then 1 end) as stage_5,count(case when stage = 6 then 1 end) as stage_6 FROM WORK.LOADSHEDDING GROUP BY day,day_name ORDER by day;
run;

proc sgplot data=WORK.DAY_COUNT;
    title Day vs Stage count;
    series x=day_name y=stage_1;
    series x=day_name y=stage_2;
    series x=day_name y=stage_3;
    series x=day_name y=stage_4;
    series x=day_name y=stage_5;
    series x=day_name y=stage_6;
    yaxis label="stage count";
run;
proc sql;
    create view hour_count as
    select hour as hour ,count(case when stage = 1 then 1 end) as stage_1,count(case when stage = 2 then 1 end) as stage_2,count(case when stage = 3 then 1 end) as stage_3,count(case when stage = 4 then 1 end) as stage_4,count(case when stage = 5 then 1 end) as stage_5,count(case when stage = 6 then 1 end) as stage_6 FROM WORK.LOADSHEDDING GROUP BY hour ORDER by hour;
run;

proc sgplot data=WORK.HOUR_COUNT;
    title Hour vs Stage count;
    series x=hour y=stage_1;
    series x=hour y=stage_2;
    series x=hour y=stage_3;
    series x=hour y=stage_4;
    series x=hour y=stage_5;
    series x=hour y=stage_6;
    yaxis label="stage count";
run;	
proc sql;
	create view dis_gen as 
	select year as year ,AVG(dispatchable_generation) as dispatchable_energy FROM WORK.GENERATION GROUP BY year ORDER BY year;
run;


proc sgplot data=WORK.DIS_GEN;
	title Average of Dispatchable energy generation;
    series x=year y=dispatchable_energy;
    yaxis label="Energy in GW";
run;

proc sql;
	create view imp_vs_exp as
	select year as year,avg(international_imports) as imports, avg(international_exports) as exports from generation group by year order by year;
	
run;


proc sgplot data=imp_vs_exp;
	title Imports vs exports;
	series x=year y=imports;
	series x=year y=exports;
	yaxis label="Energy in GW";
run;

proc sql;
	create view methods_yeild as
	select year as year ,AVG(thermal_generation) as thermal ,AVG(nuclear_generation) as nuclear ,AVG(eskom_gas_generation) as eskom_gas ,AVG(eskom_ocgt_generation) as eskom_ocgt ,AVG(pumped_water_generation) as pumped_water ,AVG(hydro_water_generation) as hydro_water ,AVG(wind) as wind ,AVG(pv) as pv ,AVG(csp) as csp ,AVG(other_re) as other_re , avg(dispatchable_ipp_ocgt) as ipp_ocgt FROM WORK.GENERATION GROUP BY year ORDER BY year;
run;

proc sgplot data=WORK.METHODS_YEILD;
	title Average of energy generation from different sources;
    series x=year y=nuclear;
    series x=year y=eskom_gas;
    series x=year y=eskom_ocgt;
    series x=year y=pumped_water;
    series x=year y=hydro_water;
    series x=year y=wind;
    series x=year y=pv;
    series x=year y=csp;
    series x=year y=other_re;
    series x=year y=ipp_ocgt;
    yaxis label="Energy in GW";
run;

proc sql;
	create view therm_vs_other as
	select year as year, avg(thermal_generation) as thermal,avg(nuclear_generation+eskom_gas_generation+eskom_ocgt_generation+hydro_water_generation+pumped_water_generation+wind+pv+csp+other_re+total_re+dispatchable_ipp_ocgt) as other from generation group by year order by year;
run;

proc sgplot data=therm_vs_other;
	title thermal vs other sources of generation;
	series x=year y=thermal;
	series x=year y=other;
	yaxis label="Energy in GW";
run;

proc sql;
	create view power_stations as
	select year as year , avg(drakensberg_gen_unit_hours) as drakensburg, avg(palmiet_gen_unit_hours) as palmiet,avg(ingula_gen_unit_hours) as ingula from WORK.generation group by year order by year;
	
run;

proc sgplot data=power_stations;
	title Average generation of power stations;
	series x=year y=drakensburg;
	series x=year y=palmiet;
	series x=year y=ingula;
	yaxis label="Energy per Unit hours";
run;
proc sql;
    create view year_vs_capacity AS
    SELECT year as year,AVG(wind_installed_capacity) as wind,AVG(pv_installed_capacity) as pv,AVG(csp_installed_capacity) as csp,AVG(other_re_installed_capacity) as other FROM WORK.CAPACITY GROUP BY year ORDER BY year;
run;

proc sgplot data=WORK.YEAR_VS_CAPACITY;
    title average of renewable energy capacity;
    yaxis label = "energy in GW";
    series x=year y=wind;
    series x=year y=pv;
    series x=year y=csp;
    series x=year y=other;
run;

quit;



