Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD081806580
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjLFDPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:15:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5B1B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:15:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE85C433C8;
        Wed,  6 Dec 2023 03:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701832523;
        bh=UtCdc+sgLzjdvXkZ1fmLKLdQbkA15fS8azoFUy1h7Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsLS4lff/K0Bn9P0P2EHcfpXD7o+LuSg/wY40jzZ2ORc22RpWMMXixgx1/DtWH2Fm
         f+Qn5VvQLUrJZtaWOKsrjo0PizgxdTeECIOC0wrVIUf7hQEHSknB6YL4Y85CW9Jc0g
         vxGCcOFlVk8GvWgo2SHG7BeUSKFVeuuz4g3lSmS44mIIBS5oBf81ZGIW2fPawysbv6
         jgtyi3ut1rPHuiBq5U6oO8v19pgnRmni6FRBvVmStyn9A5NCxA2C56LAykgBp7VgNW
         4XzGE4B3aZCFJoAIXOIFkwk8XB+hrSW/t042+tPTM8jXuZaZOT2wlTI6Pigc69r/Vk
         ghWamRpVeG0Aw==
Date:   Wed, 6 Dec 2023 11:15:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] arm64: dts: freescale: verdin-imx8mp: add support
 to mallow board
Message-ID: <20231206031518.GQ236001@dragon>
References: <20231201153929.26590-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201153929.26590-1-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 04:39:27PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add Toradex Verdin IMX8MP Mallow carrier board support. Mallow is a
> low-cost carrier board in the Verdin family with a small form factor and
> build for volume production making it ideal for industrial and embedded
> applications.
> 
> https://www.toradex.com/products/carrier-board/mallow-carrier-board
> 
> v1:
>  - https://lore.kernel.org/all/20231129164022.143340-1-francesco@dolcini.it/
> v2:
>  - remove dt nodes: eeprom_display_adapter, hwmon
>  - add Acked-by: Krzysztof
>  - correct hwmon_temp node compatible to "ti,tmp1075"
> 
> Joao Paulo Goncalves (2):
>   dt-bindings: arm: fsl: add verdin imx8mp mallow board
>   arm64: dts: freescale: verdin-imx8mp: add support to mallow board

Ok, applied this version instead.

It would be helpful if you drop a note on the previous version when you
discard it with a new one.

Shawn
