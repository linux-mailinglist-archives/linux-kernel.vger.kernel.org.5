Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5D813005
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573016AbjLNM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573021AbjLNM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:27:17 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4F11D;
        Thu, 14 Dec 2023 04:27:22 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BECRENt029318;
        Thu, 14 Dec 2023 06:27:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702556834;
        bh=VqrTS3Nf0oYZo0mbPS/YZaDCqhTgpCgDvSl+aqyP2gc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qHbBIAY/yhKJcOumqEy9eFVAI1w2ZLKgdoUBKye4rRZvijpxVN8IeSBG+2vUezRxD
         yMDs5sDp4GtDDjvkvJ7jHMLE8p3tMmMe/6PaqnkymptvbF2kguGdB86QO+lWBJ9glc
         MP9FnyJ9JcnNN9Ea42D1bW/usmCgi7KYG0sHNauo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BECRE8k059744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Dec 2023 06:27:14 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 06:27:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 06:27:13 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BECRDTA106764;
        Thu, 14 Dec 2023 06:27:13 -0600
Date:   Thu, 14 Dec 2023 06:27:13 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: Introduce J722S family of SoCs
Message-ID: <20231214122713.qx7as6grpvlq3ylw@stoic>
References: <20231213124930.3012-1-vaishnav.a@ti.com>
 <20231213124930.3012-3-vaishnav.a@ti.com>
 <20231213202705.6tspycl5qicb6gwd@germproof>
 <08eccba2-41df-91e7-c1e5-e03190402c23@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08eccba2-41df-91e7-c1e5-e03190402c23@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:07-20231214, Vaishnav Achath wrote:
[..]
> > Trim this down to what is different from AM62P?
> > 
> 
> Thanks for the review, I will trim this down in next revision, but the above is
> just a summary of the main features of this SoC, pointing to AM62P feature set
> here seems confusing to me. why does a new user/developer using J722S need to be
> aware of the existence of AM62P to just understand a high level summary about
> this device?

Since this is a reuse device. Helps with review and focus on deltas.

[...]

> >> +	l2_0: l2-cache0 {
> >> +		compatible = "cache";
> >> +		cache-unified;
> >> +		cache-level = <2>;
> >> +		cache-size = <0x80000>;
> >> +		cache-line-size = <64>;
> >> +		cache-sets = <512>;
> >> +	};
> > 
> > ^^ this is a duplication of am62p5.dtsi? what about the spins with
> > different CPUs enabled?
> > 
> 
> Yes it is a duplicate, as of now we are not aware of plan for spins with cores
> disabled, so just followed the pattern followed for other Jacinto devices
> (J721e, J7200, J721s2, J784s4).

None of the devices have been as close a reuse device as this has been.
errata in one carries over to the other etc.. There are definitely some
differences - for example: itap/otap delays for mmc those would be
unique on this device, but overrides with documentation will make
perfect sense there.

[..]
> >> +		cbass_wakeup: bus@b00000 {
> >> +			compatible = "simple-bus";
> >> +			#address-cells = <2>;
> >> +			#size-cells = <2>;
> >> +			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> >> +				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> >> +				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* WKUP CTRL MMR */
> >> +				 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM*/
> >> +				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM*/
> >> +			bootph-all;
> > 
> > Not in the bus nodes.. only in the leaf nodes please.
> > 
> > 
> > Also what is wrong with expanding the am62p to include the
> > missing bus segments instead of duplicating all of them?
> > 
> 
> We can do that, but the same would be true for AM625, AM62A and AM62P families
> and also for (J721E, J7200), since all these SoCs introduced new dtsi instead of
> resuing existing ones, I thought there would be some valid reason to have
> separate dtsi and just followed the same pattern, please let know if we need to
> reuse from AM62P here also.

See above.

[...]

> 
> >> +		};
> >> +	};
> >> +
> >> +	#include "k3-am62p-thermal.dtsi"
> > 
> > Is this correct?
> > 
> 
> I think it would be preferred to have a duplicate for J722S here as users may
> want to customize the trip points as per system and doing that without affecting
> AM62P would be preferred, but the initial information here would be same for J722S.

Please check with your hardware teams if the am62p SoC level thermal
behavior will be similar to j722s or will it be different. If it is
estimated to be different, then you'd prefer to hold off introducing
the trips till the characterization provides you with the data.

> 
> >> +};
> >> +
> >> +/*
> >> + * Include peripherals for each bus segment derived
> >> + * from AM62P and overrides specific to J722S.
> >> + */
> >> +#include "k3-am62p-main.dtsi"
> >> +#include "k3-am62p-mcu.dtsi"
> >> +#include "k3-am62p-wakeup.dtsi"
> >> +
> >> +/* Main domain overrides */
> >> +
> >> +&cpsw3g {
> >> +	status = "disabled";
> > 
> > 	here and rest: Why disabled?
> 
> These nodes seems to have dependencies that are not merged already and would
> throw errors during boot, AM62P SoC dtsi seems to have these enabled by default
> without these dependencies met and have errors like below during boot (seen on
> AM62P with 6.7.0-rc4-next-20231211).
> 
> [   17.869092] platform 8000000.ethernet: deferred probe pending:
> am65-cpsw-nuss: Failed to request tx dma channel

OK - lets get the dependencies sorted out before merging then. I though
all the dependencies were indicated in the cover letter.

> 
> >> +};
> >> +
> >> +&inta_main_dmss {
> >> +	ti,interrupt-ranges = <5 69 35>;
> >> +};
> >> +
> >> +&mailbox0_cluster0 {
> >> +	status = "disabled";
> >> +};
> >> +
> >> +&mailbox0_cluster1 {
> >> +	status = "disabled";
> >> +};
> >> +
> >> +&mailbox0_cluster2 {
> >> +	status = "disabled";
> >> +};
> >> +
> >> +&mailbox0_cluster3 {
> >> +	status = "disabled";
> >> +};
> >> +
> 
> [    7.198470] omap-mailbox 29020000.mailbox: no available mbox devices found
> [    7.210411] omap-mailbox 29030000.mailbox: no available mbox devices found

You might want to dig into why..

> 
> >> +&oc_sram {
> >> +	reg = <0x00 0x70000000 0x00 0x40000>;
> >> +	ranges = <0x00 0x00 0x70000000 0x40000>;
> >> +};
> >> +
> >> +/* MCU domain overrides */
> >> +
> >> +&mcu_r5fss0 {
> >> +	status = "disabled";
> >> +};
> 
> [    7.492406] platform 79000000.r5f: configured R5F for remoteproc mode
> [    7.499887] platform 79000000.r5f: device does not have reserved memory
> regions, ret = -22
> [    7.508271] k3_r5_rproc bus@f0000:bus@4000000:r5fss@79000000: reserved memory
> init failed, ret = -22
> [    7.517549] remoteproc remoteproc0: releasing 79000000.r5f
> [    7.523338] k3_r5_rproc bus@f0000:bus@4000000:r5fss@79000000:
> k3_r5_cluster_rproc_init failed, ret = -22
> [    7.532993] k3_r5_rproc: probe of bus@f0000:bus@4000000:r5fss@79000000 failed
> with error -22

Yes, and the approach should rather be to disable the remote procs in
the board or at the SoC dtsi in a consistent manner. I had previously
suggested to do that SoC level (which means at am62p dtsi) since the remoteprocs have direct
dependency on how the memory layouts are partitioned in board.dts - but
i had asked folks working on remote procs to do that consistently across
SoCs. I don't see that having been done so far.

> 
> >> +
> >> +/* wakeup domain overrides */
> >> +
> >> +&wkup_r5fss0 {
> >> +	status = "disabled";
> >> +};
> 
> [    7.576576] platform 78000000.r5f: configured R5F for IPC-only mode
> [    7.605535] platform 78000000.r5f: device does not have reserved memory
> regions, ret = -22
> [    7.613942] k3_r5_rproc bus@f0000:bus@b00000:r5fss@78000000: reserved memory
> init failed, ret = -22
> [    7.635990] remoteproc remoteproc0: releasing 78000000.r5f
> [    7.648639] k3_r5_rproc bus@f0000:bus@b00000:r5fss@78000000:
> k3_r5_cluster_rproc_init failed, ret = -22
> [    7.664043] k3_r5_rproc: probe of bus@f0000:bus@b00000:r5fss@78000000 failed
> with error -22

See above.

> 
> >> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> >> index 2a4e0e084d69..591be4489f37 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> >> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> >> @@ -59,6 +59,9 @@
> >>  #define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> >>  #define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> >>  
> >> +#define J722S_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> >> +#define J722S_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> >> +
> >>  #define J784S4_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> >>  #define J784S4_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> >>  
> >> -- 
> >> 2.17.1
> >>
> 
> 0 - AM62P Boot logs (next-20231211) -
> https://gist.github.com/vaishnavachath/7143da253bc708a1e60a13fe081d3914
> 
> To avoid these errors I am keeping these disabled, can we add support for these
> also as part of the initial support addition series? then there is no need for
> disabling these.

Fix them, then introduce j722s.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
