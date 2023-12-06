Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57926806572
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376278AbjLFDJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:09:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5431B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:09:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEBDC433C8;
        Wed,  6 Dec 2023 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701832174;
        bh=zcWwd/zNBnDd5iKkMSGKOiqlIWkP3cLmgX22BTg2xIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDfkM6tHqIMnhm9R8ZdcVRqO0AN34bh4cDg45vPOw8hX9aErAhXF713FUFqz8R+Pb
         yQz90VlN53KlcFwkBJEwvvwhepmZjK/KxfMr8kTaS4ZgisUtJg3yV+tAxRnRYC+TFB
         KW4nxC3ri9GvHr0iTP9VuMyGLG+UlTGKiJ0Mb98mHBOUZI+v2Dubd+UXRl9jOIg/hg
         TSv19PsVcMvSGIct4NICwQryfPr5H2halImqL3cZ5B3Ww2tkvUvAF/zK/Ep9sO7js/
         Yk3ohtiuSQx2usKstiJB48qYSmPv6QI8MRxtT/EV3nXu8FGl8f9+72JMP/1rHFaqrj
         cTArZ193BxBIg==
Date:   Wed, 6 Dec 2023 11:09:26 +0800
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
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: verdin-imx8mm: add support
 to mallow board
Message-ID: <20231206030926.GP236001@dragon>
References: <20231201150733.24454-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201150733.24454-1-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 04:07:31PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add Toradex Verdin IMX8MM Mallow carrier board support. Mallow is a
> low-cost carrier board in the Verdin family with a small form factor and
> build for volume production making it ideal for industrial and embedded
> applications.
> 
> https://www.toradex.com/products/carrier-board/mallow-carrier-board
> 
> Joao Paulo Goncalves (2):
>   dt-bindings: arm: fsl: add verdin imx8mm mallow board
>   arm64: dts: freescale: verdin-imx8mm: add support to mallow board

Applied both, thanks!
