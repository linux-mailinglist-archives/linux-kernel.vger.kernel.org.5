Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD57ACD64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjIYBFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIYBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:05:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FAC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:05:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4054C433C7;
        Mon, 25 Sep 2023 01:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695603899;
        bh=q/25EilKw76Pz85a9a3rbtBKovmJDo+FK6RUo8sLg3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRyL11cIDlnm78qNzeLIZ44Q9GMLib0A2pWXQS1P+ikFkAHUXAK8hHPDekVtW02Em
         psdR1h5mCAMHV9IWqNGgfnR7ZBbAyQe1g97ZW9jnVmopklifb5+mnDTH1Sz+6ej+GW
         7uteibgtKjBXBU/JYQ/I9fmRdNF/e0GbIcTm1YphI/h0imw4NOiEq8FgV32Ah2dC1Q
         krG+8eZumxCrXvKtNVlACeKPP4dqreuBbMjQIWvioTUjaXbOdrEcVNKWrBys4vVfRX
         jKrSLQaML8+v9mg1wfFkadQ8a0zH2qldgvJvCcwqS+OFg5bNnZAq9lK6AcnvkCsBdk
         bPLCukVkcV40w==
Date:   Mon, 25 Sep 2023 09:04:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH v2 6/6] MAINTAINERS: add tqml device trees to TQ-Systems
 entry
Message-ID: <20230925010449.GB7231@dragon>
References: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
 <20230829-for-ml-tqmls10xxa-v2-test-v2-6-b1da63785b25@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829-for-ml-tqmls10xxa-v2-test-v2-6-b1da63785b25@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd

On Tue, Aug 29, 2023 at 11:27:02AM +0200, Gregor Herburger wrote:
> Update file entries for TQ-Systems Layerscape modules.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  MAINTAINERS | 2 ++

I do not have a branch for this file, so you may want to send the
change to Arnd directly.

Shawn

>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38ea23fa1b00..c1e9a5415d30 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21788,9 +21788,11 @@ W:	https://www.tq-group.com/en/products/tq-embedded/
>  F:	arch/arm/boot/dts/imx*mba*.dts*
>  F:	arch/arm/boot/dts/imx*tqma*.dts*
>  F:	arch/arm/boot/dts/mba*.dtsi
> +F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
>  F:	arch/arm64/boot/dts/freescale/mba*.dtsi
> +F:	arch/arm64/boot/dts/freescale/tqml*.dts*
>  F:	drivers/gpio/gpio-tqmx86.c
>  F:	drivers/mfd/tqmx86.c
>  F:	drivers/watchdog/tqmx86_wdt.c
> 
> -- 
> 2.34.1
> 
