#!/bin/awk -f

BEGIN {
	INTERVAL = 0.992; # somebit less than a second, because the script takes some time itself.

	ETH_MAX_IN = 368640; # bytes/s
	ETH_MAX_OUT = 59392;

	DATE_CMD = "LANG=en_US date +\"%X %a, %e %b\"";
    CPU_MHZ_CMD = "cat /proc/cpuinfo |grep MHz"; # CPU MHz
    CPU_TEMP_CMD = "sensors |grep 'CPU Temp'"; # CPU temperature
    CPU0_CMD = "cat /proc/stat |grep cpu0"; # first core
    CPU1_CMD = "cat /proc/stat |grep cpu1"; # second core
    GPU_TEMP_CMD = "nvidia-settings -q gpucoretemp |grep Attribute |awk '{print $4}' |cut -c1-2"; # GPU temperature (nvidia)
    MEM_CMD = "free -m |grep Mem"; # memory
    CACHE_CMD = "free -m |grep buffers/cache"; # cached
    SWAP_CMD = "free -m |grep Swap"; # swap
    MPD_CMD = "mpc"; # mpd
    VOL_CMD = "mpc | grep volume | cut --delimiter=':' -f2 | cut -c1-3"; # Volume (MPD)


	# enable(1)/disable(0) components
	DATE_STR = 1;		# date string according to DATE_CMD
	ETH_IN_KBS = 1;		# incoming traffic kb/s (about)
	ETH_IN_PERCENT = 1;	# incoming traffic in percent (0 to ETH_MAX_IN)
	ETH_OUT_KBS = 1;	# outgoing traffic kb/s (about)
	ETH_OUT_PERCENT = 1;	# outgoing traffic in percent (0 to ETH_MAX_OUT)
	MEM_PERCENT = 1;	# used mem in percent
	SWAP_PERCENT = 1;	# used swap space in percent
	CPU0 = 1;		# CPU in percent (first core)
	CPU1 = 0;		# CPU in percent (second core)
	CPU_MHZ = 0;		# CPU MHz
	CPU_TEMP = 0;		# CPU temperature
	GPU_TEMP = 1;		# GPU temperature (nvidia)
	MPD = 1;		# MPD playing info
	VOL = 1;		# Volume info
}

# edit according to the ~/.awsomerc setup (names of widgets...)
# NOTE: awk directly joins strings separated by any whitespaces.
# \n is a newline, and \ at the end is needed; so all belongs to data = ...
function print_data()
{
    data =   "0 widget_tell tb_date "    date_str " "    "\n"\
             "0 widget_tell tb_cpu_mhz " mhz             "\n"\
             "0 widget_tell gr_cpu "    cpu_total "," cpu_user "," cpu_nice "\n"\
             "0 widget_tell tb_gpu_temp " temp_gpu       "\n"\
             "0 widget_tell pb_mem "     mem_percent "," swap_percent "\n"\
	         "0 widget_tell tb_net_in "  eth_in_kbs      "\n"\
             "0 widget_tell tb_net_out " eth_out_kbs     "\n"\
             "0 widget_tell gr_net_in "  eth_in_percent  "\n"\
             "0 widget_tell gr_net_out " eth_out_percent "\n"\
             "0 widget_tell tb_mpd "     mpd_info        "\n"\
             "0 widget_tell pb_vol "     vol_info        "\n"

    print data;
}


{ 
  cpu_old_sum = cpu_old_idle = 0;
  cpu1_old_sum = cpu1_old_idle = 0;
  eth_in_old_bytes = eth_out_old_bytes = 0;

  while (!system("sleep "INTERVAL))
  {
    #############################################
    # date -> date_str
    if (DATE_STR)
    {
      DATE_CMD | getline date_str;
      close(DATE_CMD);
    }
    #############################################
    # CPU MHz
    if (CPU_MHZ)
    {
      CPU_MHZ_CMD | getline;
      close(CPU_MHZ_CMD);

    mhz = sprintf("%1.1f", ($4 / 1000));
    }
    #############################################
    # CPU temperature
    if (CPU_TEMP)
    {
      CPU_TEMP_CMD | getline;
      close(CPU_TEMP_CMD);

    temp_cpu = $3;
    }
    #############################################
    # cpu -> cpu_percent
    # $2 = user, $3 = nice, $4 = system, $5 = idle (together = 100/second)
    # so diffs of: $2+$3+$4 / all-together * 100 = percent
    #          or: 100 - ( $5 / all-together) * 100 = percent
    #          or: 100 - 100 * ( $5 / all-together)= percent
    # cpu -> cpu_percent
    # $2 = user, $3 = nice, $4 = system, $5 = idle (together = 100/second)
    # so diffs of: $2+$3+$4 / all-together * 100 = percent
    #          or: 100 - ( $5 / all-together) * 100 = percent
    #          or: 100 - 100 * ( $5 / all-together)= percent
    if (CPU0)
    {

      CPU0_CMD | getline;
      close(CPU0_CMD);

      cpu_new_sum = $2 + $3 + $4 + $5; # all-together
      diff = cpu_new_sum - cpu_old_sum;

      # print "user diff:" $2 - cpu_old_user " nice diff:" $3 - cpu_old_nice\
      #            " idle diff:" $5 - cpu_old_idle " total diff:" diff

      if (diff > 0) # should be always (theoretically...)
      {
        cpu_user =  100 * ($2 - cpu_old_user) / diff;
        cpu_nice =  100 * ($3 - cpu_old_nice) / diff;
        cpu_total = 100 - 100 * ($5 - cpu_old_idle) / diff;
      }

      cpu_old_sum = cpu_new_sum;
      cpu_old_user = $2;
      cpu_old_nice = $3;
      cpu_old_idle = $5;
    }
    #############################################
    if (CPU1)
    {

      CPU1_CMD | getline;
      close(CPU1_CMD);

      cpu1_new_sum = $2 + $3 + $4 + $5;
      diff = cpu1_new_sum - cpu1_old_sum;
      
      if (diff > 0)
      {
        cpu1_user =  100 * ($2 - cpu1_old_user) / diff;
        cpu1_nice =  100 * ($3 - cpu1_old_nice) / diff;
        cpu1_total = 100 - 100 * ($5 - cpu1_old_idle) / diff;
      }

      cpu1_old_sum = cpu1_new_sum;
      cpu1_old_user = $2;
      cpu1_old_nice = $3;
      cpu1_old_idle = $5;
    }
    #############################################
    # GPU temperature (nvidia)
    if (GPU_TEMP)
    {
      GPU_TEMP_CMD | getline;
      close(GPU_TEMP_CMD);

    temp_gpu = $1;
    }
    #############################################

    if (MEM_PERCENT || SWAP_PERCENT)
    {

      MEM_CMD | getline;
      close(MEM_CMD);
      mem_total = $2;

      CACHE_CMD | getline;
      close(CACHE_CMD);
      cache = $3;

      SWAP_CMD | getline;
      close(SWAP_CMD);
      swap_total = $2;
      swap_used = $3;

      mem_percent = (cache / mem_total) * 100;
      swap_percent = (swap_used / swap_total) * 100;
    }
    #############################################
    # ethernet (in kb/update-interval (about a second))
    if (ETH_IN_KBS || ETH_OUT_KBS || ETH_IN_PERCENT || ETH_OUT_PERCENT)
    {
      oldFS = FS;
      FS = "[: ]+";
      while ((getline < "/proc/net/dev") > 0)
      {
        if (match($0, /eth0/))
        {
          eth_in_kbs = sprintf("%5.1f", ($3 - eth_in_old_bytes) / 1024 / INTERVAL);
          eth_in_percent = ($3 - eth_in_old_bytes) * 100 / ETH_MAX_IN;
          if (eth_in_percent > 100)
            eth_in_percent = 100;
          eth_in_old_bytes = $3;
          eth_out_kbs = sprintf("%5.1f", ($11 - eth_out_old_bytes) / 1024 / INTERVAL);
          eth_out_percent = ($11 - eth_out_old_bytes) * 100 / ETH_MAX_OUT;
          if (eth_out_percent > 100)
            eth_out_percent = 100;
          eth_out_old_bytes = $11;
          break;
        }
      }
      close("/proc/net/dev");
      FS = oldFS;
    }
    #############################################
    # MPD Atrist + Track
    if (MPD)
    {
      MPD_CMD | getline;
      close(MPD_CMD);

      mpd_info = $0;
    }
    #############################################
    # Volume
    if (VOL)
    {
      VOL_CMD | getline;
      close(VOL_CMD);

      vol_info = $0;
    }
    #############################################

  print_data();
  }
}

