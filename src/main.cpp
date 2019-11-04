extern "C"{
#include <rte_common.h>
#include <rte_config.h>
#include <rte_errno.h>
#include <rte_ethdev.h>
#include <rte_ip.h>
#include <rte_mbuf.h>
}


int main(int argc, char* argv[])
{

	int ret = rte_eal_init(argc, argv);
	if (ret < 0)
	{	rte_exit(EXIT_FAILURE, "EAL Init failed\n");}


		rte_eal_cleanup();
}