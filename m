Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEA8064F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjLFC0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFC0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5A183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:26:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975DDC433C8;
        Wed,  6 Dec 2023 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701829611;
        bh=cpFL9MGQgPJ2RJM2R2TvLlDa4Q3S3v1RV1gPP5xUbQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1pbYF3rEDuNEB/OJDqJq97XDGHkQk4l7Z59jbAbgwSZdmuwZKGLW0kbKQcApW9CG
         W61N/zjW/M+06sSbkwojX9uparXIrm8EpgFqWv3oqaU45nBQa1YcUBxNU2aoAJQzCt
         gYP6bweqkBqKZXGjof8sk5PSsVBINJqLi/jIXKtHuyOXK3Xa5HxePfGUiBf5Svj1on
         qHL5ruA1vVgDodtyArb8BbQDvh8niN8e57fG4gIkbormuDWDEzE8CgiukTiWa+k3k5
         +Oou8uuhviWGN4e87QR3NJK3gbu2vL3ysnD1CYA566zzqY7wht6CjxQPolIlMSDKNA
         y5MnL2/HT7BLw==
Date:   Wed, 6 Dec 2023 10:26:45 +0800
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
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: verdin-imx8mp: add support
 to mallow board
Message-ID: <20231206022645.GK236001@dragon>
References: <20231129164022.143340-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129164022.143340-1-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:40:20PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add Toradex Verdin IMX8MP Mallow carrier board support. Mallow is a
> low-cost carrier board in the Verdin family with a small form factor and
> build for volume production making it ideal for industrial and embedded
> applications.
> 
> https://www.toradex.com/products/carrier-board/mallow-carrier-board
> 
> Joao Paulo Goncalves (2):
>   dt-bindings: arm: fsl: add verdin imx8mp mallow board
>   arm64: dts: freescale: verdin-imx8mp: add support to mallow board

Applied both, thanks!
