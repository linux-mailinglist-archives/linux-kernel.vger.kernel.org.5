Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65FF7D581C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjJXQZC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbjJXQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:24:59 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C7AC;
        Tue, 24 Oct 2023 09:24:56 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qvKD3-003zbN-LV; Tue, 24 Oct 2023 18:24:49 +0200
Received: from p57bd9695.dip0.t-ipconnect.de ([87.189.150.149] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qvKD3-0002dk-Da; Tue, 24 Oct 2023 18:24:49 +0200
Message-ID: <7162f30d9a6d04941dc1d1e6a6d2ea2855bb9d3c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/4] [v2] sh: remove unused sh4-202 support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Oct 2023 18:24:48 +0200
In-Reply-To: <20230914155523.3839811-2-arnd@kernel.org>
References: <20230914155523.3839811-1-arnd@kernel.org>
         <20230914155523.3839811-2-arnd@kernel.org>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.149
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 17:55 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This early prototype of the SH4 CPU was only used in
> the "microdev" board that is now removed, so all of the
> sh4-202 supoprt can also be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/Kconfig                        |   5 -
>  arch/sh/kernel/cpu/sh4/Makefile        |   4 -
>  arch/sh/kernel/cpu/sh4/clock-sh4-202.c | 174 -------------------------
>  arch/sh/kernel/cpu/sh4/setup-sh4-202.c | 139 --------------------
>  4 files changed, 322 deletions(-)
>  delete mode 100644 arch/sh/kernel/cpu/sh4/clock-sh4-202.c
>  delete mode 100644 arch/sh/kernel/cpu/sh4/setup-sh4-202.c
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d3df67f215ca5..d785329e57151 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -383,10 +383,6 @@ config CPU_SUBTYPE_SH7760
>  	bool "Support SH7760 processor"
>  	select CPU_SH4
>  
> -config CPU_SUBTYPE_SH4_202
> -	bool "Support SH4-202 processor"
> -	select CPU_SH4
> -
>  # SH-4A Processor Support
>  
>  config CPU_SUBTYPE_SH7723
> @@ -517,7 +513,6 @@ config SH_PCLK_FREQ
>  			      CPU_SUBTYPE_SH7263 || \
>  			      CPU_SUBTYPE_MXG
>  	default "60000000" if CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
> -	default "66000000" if CPU_SUBTYPE_SH4_202
>  	default "50000000"
>  	help
>  	  This option is used to specify the peripheral clock frequency.
> diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
> index 00c16331e07e5..02e3ee16e15ce 100644
> --- a/arch/sh/kernel/cpu/sh4/Makefile
> +++ b/arch/sh/kernel/cpu/sh4/Makefile
> @@ -23,15 +23,11 @@ obj-$(CONFIG_CPU_SUBTYPE_SH7091)	+= setup-sh7750.o
>  obj-$(CONFIG_CPU_SUBTYPE_SH7751)	+= setup-sh7750.o
>  obj-$(CONFIG_CPU_SUBTYPE_SH7751R)	+= setup-sh7750.o
>  obj-$(CONFIG_CPU_SUBTYPE_SH7760)	+= setup-sh7760.o
> -obj-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= setup-sh4-202.o
>  
>  # Primary on-chip clocks (common)
>  ifndef CONFIG_CPU_SH4A
>  clock-$(CONFIG_CPU_SH4)			:= clock-sh4.o
>  endif
>  
> -# Additional clocks by subtype
> -clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
> -
>  obj-y					+= $(clock-y)
>  obj-$(CONFIG_PERF_EVENTS)		+= $(perf-y)
> diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
> deleted file mode 100644
> index c1cdef763cb25..0000000000000
> --- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
> +++ /dev/null
> @@ -1,174 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/kernel/cpu/sh4/clock-sh4-202.c
> - *
> - * Additional SH4-202 support for the clock framework
> - *
> - *  Copyright (C) 2005  Paul Mundt
> - */
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -#include <linux/clkdev.h>
> -#include <asm/clock.h>
> -#include <asm/freq.h>
> -
> -#define CPG2_FRQCR3	0xfe0a0018
> -
> -static int frqcr3_divisors[] = { 1, 2, 3, 4, 6, 8, 16 };
> -static int frqcr3_values[]   = { 0, 1, 2, 3, 4, 5, 6  };
> -
> -static unsigned long emi_clk_recalc(struct clk *clk)
> -{
> -	int idx = __raw_readl(CPG2_FRQCR3) & 0x0007;
> -	return clk->parent->rate / frqcr3_divisors[idx];
> -}
> -
> -static inline int frqcr3_lookup(struct clk *clk, unsigned long rate)
> -{
> -	int divisor = clk->parent->rate / rate;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++)
> -		if (frqcr3_divisors[i] == divisor)
> -			return frqcr3_values[i];
> -
> -	/* Safe fallback */
> -	return 5;
> -}
> -
> -static struct sh_clk_ops sh4202_emi_clk_ops = {
> -	.recalc		= emi_clk_recalc,
> -};
> -
> -static struct clk sh4202_emi_clk = {
> -	.flags		= CLK_ENABLE_ON_INIT,
> -	.ops		= &sh4202_emi_clk_ops,
> -};
> -
> -static unsigned long femi_clk_recalc(struct clk *clk)
> -{
> -	int idx = (__raw_readl(CPG2_FRQCR3) >> 3) & 0x0007;
> -	return clk->parent->rate / frqcr3_divisors[idx];
> -}
> -
> -static struct sh_clk_ops sh4202_femi_clk_ops = {
> -	.recalc		= femi_clk_recalc,
> -};
> -
> -static struct clk sh4202_femi_clk = {
> -	.flags		= CLK_ENABLE_ON_INIT,
> -	.ops		= &sh4202_femi_clk_ops,
> -};
> -
> -static void shoc_clk_init(struct clk *clk)
> -{
> -	int i;
> -
> -	/*
> -	 * For some reason, the shoc_clk seems to be set to some really
> -	 * insane value at boot (values outside of the allowable frequency
> -	 * range for instance). We deal with this by scaling it back down
> -	 * to something sensible just in case.
> -	 *
> -	 * Start scaling from the high end down until we find something
> -	 * that passes rate verification..
> -	 */
> -	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++) {
> -		int divisor = frqcr3_divisors[i];
> -
> -		if (clk->ops->set_rate(clk, clk->parent->rate / divisor) == 0)
> -			break;
> -	}
> -
> -	WARN_ON(i == ARRAY_SIZE(frqcr3_divisors));	/* Undefined clock */
> -}
> -
> -static unsigned long shoc_clk_recalc(struct clk *clk)
> -{
> -	int idx = (__raw_readl(CPG2_FRQCR3) >> 6) & 0x0007;
> -	return clk->parent->rate / frqcr3_divisors[idx];
> -}
> -
> -static int shoc_clk_verify_rate(struct clk *clk, unsigned long rate)
> -{
> -	struct clk *bclk = clk_get(NULL, "bus_clk");
> -	unsigned long bclk_rate = clk_get_rate(bclk);
> -
> -	clk_put(bclk);
> -
> -	if (rate > bclk_rate)
> -		return 1;
> -	if (rate > 66000000)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int shoc_clk_set_rate(struct clk *clk, unsigned long rate)
> -{
> -	unsigned long frqcr3;
> -	unsigned int tmp;
> -
> -	/* Make sure we have something sensible to switch to */
> -	if (shoc_clk_verify_rate(clk, rate) != 0)
> -		return -EINVAL;
> -
> -	tmp = frqcr3_lookup(clk, rate);
> -
> -	frqcr3 = __raw_readl(CPG2_FRQCR3);
> -	frqcr3 &= ~(0x0007 << 6);
> -	frqcr3 |= tmp << 6;
> -	__raw_writel(frqcr3, CPG2_FRQCR3);
> -
> -	clk->rate = clk->parent->rate / frqcr3_divisors[tmp];
> -
> -	return 0;
> -}
> -
> -static struct sh_clk_ops sh4202_shoc_clk_ops = {
> -	.init		= shoc_clk_init,
> -	.recalc		= shoc_clk_recalc,
> -	.set_rate	= shoc_clk_set_rate,
> -};
> -
> -static struct clk sh4202_shoc_clk = {
> -	.flags		= CLK_ENABLE_ON_INIT,
> -	.ops		= &sh4202_shoc_clk_ops,
> -};
> -
> -static struct clk *sh4202_onchip_clocks[] = {
> -	&sh4202_emi_clk,
> -	&sh4202_femi_clk,
> -	&sh4202_shoc_clk,
> -};
> -
> -static struct clk_lookup lookups[] = {
> -	/* main clocks */
> -	CLKDEV_CON_ID("emi_clk", &sh4202_emi_clk),
> -	CLKDEV_CON_ID("femi_clk", &sh4202_femi_clk),
> -	CLKDEV_CON_ID("shoc_clk", &sh4202_shoc_clk),
> -};
> -
> -int __init arch_clk_init(void)
> -{
> -	struct clk *clk;
> -	int i, ret = 0;
> -
> -	cpg_clk_init();
> -
> -	clk = clk_get(NULL, "master_clk");
> -	for (i = 0; i < ARRAY_SIZE(sh4202_onchip_clocks); i++) {
> -		struct clk *clkp = sh4202_onchip_clocks[i];
> -
> -		clkp->parent = clk;
> -		ret |= clk_register(clkp);
> -	}
> -
> -	clk_put(clk);
> -
> -	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> -
> -	return ret;
> -}
> diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
> deleted file mode 100644
> index e6737f3d0df25..0000000000000
> --- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
> +++ /dev/null
> @@ -1,139 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * SH4-202 Setup
> - *
> - *  Copyright (C) 2006  Paul Mundt
> - *  Copyright (C) 2009  Magnus Damm
> - */
> -#include <linux/platform_device.h>
> -#include <linux/init.h>
> -#include <linux/serial.h>
> -#include <linux/serial_sci.h>
> -#include <linux/sh_timer.h>
> -#include <linux/sh_intc.h>
> -#include <linux/io.h>
> -#include <asm/platform_early.h>
> -
> -static struct plat_sci_port scif0_platform_data = {
> -	.scscr		= SCSCR_REIE,
> -	.type		= PORT_SCIF,
> -};
> -
> -static struct resource scif0_resources[] = {
> -	DEFINE_RES_MEM(0xffe80000, 0x100),
> -	DEFINE_RES_IRQ(evt2irq(0x700)),
> -	DEFINE_RES_IRQ(evt2irq(0x720)),
> -	DEFINE_RES_IRQ(evt2irq(0x760)),
> -	DEFINE_RES_IRQ(evt2irq(0x740)),
> -};
> -
> -static struct platform_device scif0_device = {
> -	.name		= "sh-sci",
> -	.id		= 0,
> -	.resource	= scif0_resources,
> -	.num_resources	= ARRAY_SIZE(scif0_resources),
> -	.dev		= {
> -		.platform_data	= &scif0_platform_data,
> -	},
> -};
> -
> -static struct sh_timer_config tmu0_platform_data = {
> -	.channels_mask = 7,
> -};
> -
> -static struct resource tmu0_resources[] = {
> -	DEFINE_RES_MEM(0xffd80000, 0x30),
> -	DEFINE_RES_IRQ(evt2irq(0x400)),
> -	DEFINE_RES_IRQ(evt2irq(0x420)),
> -	DEFINE_RES_IRQ(evt2irq(0x440)),
> -};
> -
> -static struct platform_device tmu0_device = {
> -	.name		= "sh-tmu",
> -	.id		= 0,
> -	.dev = {
> -		.platform_data	= &tmu0_platform_data,
> -	},
> -	.resource	= tmu0_resources,
> -	.num_resources	= ARRAY_SIZE(tmu0_resources),
> -};
> -
> -static struct platform_device *sh4202_devices[] __initdata = {
> -	&scif0_device,
> -	&tmu0_device,
> -};
> -
> -static int __init sh4202_devices_setup(void)
> -{
> -	return platform_add_devices(sh4202_devices,
> -				    ARRAY_SIZE(sh4202_devices));
> -}
> -arch_initcall(sh4202_devices_setup);
> -
> -static struct platform_device *sh4202_early_devices[] __initdata = {
> -	&scif0_device,
> -	&tmu0_device,
> -};
> -
> -void __init plat_early_device_setup(void)
> -{
> -	sh_early_platform_add_devices(sh4202_early_devices,
> -				   ARRAY_SIZE(sh4202_early_devices));
> -}
> -
> -enum {
> -	UNUSED = 0,
> -
> -	/* interrupt sources */
> -	IRL0, IRL1, IRL2, IRL3, /* only IRLM mode supported */
> -	HUDI, TMU0, TMU1, TMU2, RTC, SCIF, WDT,
> -};
> -
> -static struct intc_vect vectors[] __initdata = {
> -	INTC_VECT(HUDI, 0x600),
> -	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
> -	INTC_VECT(TMU2, 0x440), INTC_VECT(TMU2, 0x460),
> -	INTC_VECT(RTC, 0x480), INTC_VECT(RTC, 0x4a0),
> -	INTC_VECT(RTC, 0x4c0),
> -	INTC_VECT(SCIF, 0x700), INTC_VECT(SCIF, 0x720),
> -	INTC_VECT(SCIF, 0x740), INTC_VECT(SCIF, 0x760),
> -	INTC_VECT(WDT, 0x560),
> -};
> -
> -static struct intc_prio_reg prio_registers[] __initdata = {
> -	{ 0xffd00004, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
> -	{ 0xffd00008, 0, 16, 4, /* IPRB */ { WDT, 0, 0, 0 } },
> -	{ 0xffd0000c, 0, 16, 4, /* IPRC */ { 0, 0, SCIF, HUDI } },
> -	{ 0xffd00010, 0, 16, 4, /* IPRD */ { IRL0, IRL1, IRL2, IRL3 } },
> -};
> -
> -static DECLARE_INTC_DESC(intc_desc, "sh4-202", vectors, NULL,
> -			 NULL, prio_registers, NULL);
> -
> -static struct intc_vect vectors_irlm[] __initdata = {
> -	INTC_VECT(IRL0, 0x240), INTC_VECT(IRL1, 0x2a0),
> -	INTC_VECT(IRL2, 0x300), INTC_VECT(IRL3, 0x360),
> -};
> -
> -static DECLARE_INTC_DESC(intc_desc_irlm, "sh4-202_irlm", vectors_irlm, NULL,
> -			 NULL, prio_registers, NULL);
> -
> -void __init plat_irq_setup(void)
> -{
> -	register_intc_controller(&intc_desc);
> -}
> -
> -#define INTC_ICR	0xffd00000UL
> -#define INTC_ICR_IRLM   (1<<7)
> -
> -void __init plat_irq_setup_pins(int mode)
> -{
> -	switch (mode) {
> -	case IRQ_MODE_IRQ: /* individual interrupt mode for IRL3-0 */
> -		__raw_writew(__raw_readw(INTC_ICR) | INTC_ICR_IRLM, INTC_ICR);
> -		register_intc_controller(&intc_desc_irlm);
> -		break;
> -	default:
> -		BUG();
> -	}
> -}

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
