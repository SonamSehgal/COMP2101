######################################### CPU INFORMATION ######################################################

cpuReport() {
	#Cmd to get the cpu manufacturer.
	cpumanufac=$(echo "$lshwOutput" | grep 'Model name:' | sed 's/,"Model name: *//') 
	if [ -z "$cmpdescription" ]; then 
		cpumanufac='Error! Data is unavailable.'
	else
		cpumanufac=$(echo "$lscpuOutput" | grep 'Model name:' | sed 's/,"Model name: *//')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the Cpu architecture.
	cpuarchi=$(echo "$lscpuOutput" | grep 'Architecture: ' | awk '{print$2}')
	if [ -z "$cmpdescription" ]; then 
		cpuarchi='Error! Data is unavailable.'
	else
		cpuarchi=$(echo "$lscpuOutput" | grep 'Architecture: ' | awk '{print$2}')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the Cpu core count.
	cpucore=$(echo "$lscpuOutput" | grep 'CPU(s): ' | head -1 | awk '{print$2}')
	if [ -z "$cmpdescription" ]; then 
		cpucore='Error! Data is unavailable.'
	else
		cpucore=$(echo "$lscpuOutput" | grep 'CPU(s): ' | head -1 | awk '{print$2}')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the Cpu maximum speed.
	cpuspeed=$(echo "$lshwOutput" -class cpu | grep 'capacity: ' | head -1 | awk '{print$2}')
	if [ -z "$cmpdescription" ]; then 
		cpuspeed='Error! Data is unavailable.'
	else
		cpuspeed=$(echo "$lshwOutput" -class cpu | grep 'capacity: ' | head -1 | awk '{print$2}')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the size of L1d.
	sizeL1d=$(echo "$lscpuOutput" | grep 'L1d ' | awk '{print $3}')
	if [ -z "$cmpdescription" ]; then 
		sizeL1d='Error! Data is unavailable.'
	else
		sizeL1d=$(echo "$lscpuOutput" | grep 'L1d ' | awk '{print $3}')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the size of L1i.
	sizeL1i=$(echo "$lscpuOutput" | grep 'L1i ' | awk '{print $3}')
	if [ -z "$cmpdescription" ]; then 
		sizeL1i='Error! Data is unavailable.'
	else
		sizeL1i=$(echo "$lscpuOutput" | grep 'L1i ' | awk '{print $3}')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the size of L2.
	sizeL2=$(echo "$lscpuOutput" | grep 'L2' | awk '{print $3}')
	if [ -z "$cmpdescription" ]; then 
		sizeL2='Error! Data is unavailable.'
	else
		sizeL2=$(echo "$lscpuOutput" | grep 'L2 ' | awk '{print $3}')
	fi
	#-----------------------------------------------------------------------------------------------
	#Cmd to get the size of L3.
	sizeL3=$(echo "$lscpuOutput" | grep 'L3' | awk '{print $3}')
	if [ -z "$cmpdescription" ]; then 
		sizeL3='Error! Data is unavailable.'
	else
		sizeL3=$(echo "$lscpuOutput" | grep 'L3 ' | awk '{print $3}')
	fi
}
