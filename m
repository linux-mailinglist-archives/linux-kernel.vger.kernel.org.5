Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE87CAE77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjJPQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJPQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:06:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78083;
        Mon, 16 Oct 2023 09:05:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qsQ6M-0000kQ-Os; Mon, 16 Oct 2023 18:05:54 +0200
Message-ID: <a403f9b7-697e-4000-8a31-f54438718748@leemhuis.info>
Date:   Mon, 16 Oct 2023 18:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 006/191] arm_pmu: acpi: Add a representative platform
 device for TRBE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sasha Levin <sashal@kernel.org>
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084015.550509169@linuxfoundation.org>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20231016084015.550509169@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1697472358;155127a0;
X-HE-SMSGID: 1qsQ6M-0000kQ-Os
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.23 10:39, Greg Kroah-Hartman wrote:
> 6.5-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> [ Upstream commit 1aa3d0274a4aac338ee45a3dfc3b17c944bcc2bc ]
> 
> ACPI TRBE does not have a HID for identification which could create and add
> a platform device into the platform bus. Also without a platform device, it
> cannot be probed and bound to a platform driver.
> 
> This creates a dummy platform device for TRBE after ascertaining that ACPI
> provides required interrupts uniformly across all cpus on the system. This
> device gets created inside drivers/perf/arm_pmu_acpi.c to accommodate TRBE
> being built as a module.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Link: https://lore.kernel.org/r/20230817055405.249630-3-anshuman.khandual@arm.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Stable-dep-of: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Got a compiler error when using Fedora's stable kernel config and
compiling 6.5.8-rc1 for ARM64; not totally sure, but from the error msg
I suspect it's caused by the change quoted above.

"""
+ /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g
-grecord-gcc-switches -pipe -Wall -Werror=format-security
-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1
-mbranch-protection=standard -fasynchronous-unwind-tables
-fstack-clash-protection' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed
-Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1
-specs=/usr/lib/rpm/redhat/redhat-package-notes' ARCH=arm64 'KCFLAGS= '
WITH_GCOV=0 -j4 vmlinuz.efi
drivers/perf/arm_pmu_acpi.c: In function 'arm_trbe_acpi_register_device':
drivers/perf/arm_pmu_acpi.c:164:19: error: implicit declaration of
function 'arm_acpi_register_pmu_device'; did you mean
'arm_spe_acpi_register_device'? [-Werror=implicit-function-declaration]
  164 |         int ret = arm_acpi_register_pmu_device(&trbe_dev,
ACPI_MADT_GICC_TRBE,
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                   arm_spe_acpi_register_device
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:243: drivers/perf/arm_pmu_acpi.o]
Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:480: drivers/perf] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: ***
[/builddir/build/BUILD/kernel-6.5.8-rc1/linux-6.5.8-0.rc1.150.vanilla.fc37.aarch64/Makefile:2036:
.] Error 2
make: *** [Makefile:236: __sub-make] Error 2
"""

Full build log:
https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/stable-rc/fedora-37-aarch64/06529454-stablerc-stablerc-releases/builder-live.log.gz

Ciao, Thorsten

> ---
>  arch/arm64/include/asm/acpi.h |  3 +++
>  drivers/perf/arm_pmu_acpi.c   | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h  |  1 +
>  3 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bd68e1b7f29f3..4d537d56eb847 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -42,6 +42,9 @@
>  #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
>  	spe_interrupt) + sizeof(u16))
>  
> +#define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
> +	trbe_interrupt) + sizeof(u16))
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 90815ad762ebc..8baeeb369118e 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -139,6 +139,40 @@ static inline void arm_spe_acpi_register_device(void)
>  }
>  #endif /* CONFIG_ARM_SPE_PMU */
>  
> +#if IS_ENABLED(CONFIG_CORESIGHT_TRBE)
> +static struct resource trbe_resources[] = {
> +	{
> +		/* irq */
> +		.flags          = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device trbe_dev = {
> +	.name = ARMV8_TRBE_PDEV_NAME,
> +	.id = -1,
> +	.resource = trbe_resources,
> +	.num_resources = ARRAY_SIZE(trbe_resources)
> +};
> +
> +static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
> +{
> +	return gicc->trbe_interrupt;
> +}
> +
> +static void arm_trbe_acpi_register_device(void)
> +{
> +	int ret = arm_acpi_register_pmu_device(&trbe_dev, ACPI_MADT_GICC_TRBE,
> +					       arm_trbe_parse_gsi);
> +	if (ret)
> +		pr_warn("ACPI: TRBE: Unable to register device\n");
> +}
> +#else
> +static inline void arm_trbe_acpi_register_device(void)
> +{
> +
> +}
> +#endif /* CONFIG_CORESIGHT_TRBE */
> +
>  static int arm_pmu_acpi_parse_irqs(void)
>  {
>  	int irq, cpu, irq_cpu, err;
> @@ -374,6 +408,7 @@ static int arm_pmu_acpi_init(void)
>  		return 0;
>  
>  	arm_spe_acpi_register_device();
> +	arm_trbe_acpi_register_device();
>  
>  	return 0;
>  }
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index a0801f68762bf..143fbc10ecfe0 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
>  #endif /* CONFIG_ARM_PMU */
>  
>  #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
> +#define ARMV8_TRBE_PDEV_NAME "arm,trbe"
>  
>  #endif /* __ARM_PMU_H__ */
