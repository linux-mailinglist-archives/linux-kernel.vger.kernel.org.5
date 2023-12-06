Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435CB80649B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376496AbjLFBhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376424AbjLFBhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:37:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BFA1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:37:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C9BC433C7;
        Wed,  6 Dec 2023 01:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701826663;
        bh=I0bytNA2diIOyGFy1O3wHC7xlPlvzconlcUmRjza9RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1l8OICo67PYF14FjVUPWzW3TI/SyPe75hQAJXVp8f4zOWqz7bGSfdS00hWGea0FS
         UpLIRK6QiCGTgvO2utZkaVg9DFg8TlE0vEoKTIGqwb1pSPq2miCo2jZ7kdAiUjA3Ng
         coHxrc/DvSNC1w8aEffJKOq33MKAuksyG5ecXbkHgAcxMR6nU9BY9VGZs6t5kOSoGP
         apfQogME/KGPoHfUDrorz26wcR7hZF5rfZMhIpZilwlokSbXQlt6YhkdrOiNm5a1ad
         dSY+pBVAKicWgfPuUoc/+n+X+jABqXYlQR3WPDN7mMZaDYgEqGY1t6zUi4SF4bvo6X
         elLnXIlt1FxUw==
Date:   Wed, 6 Dec 2023 09:37:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v1 0/3] ARM: dts: imx: Add mmc aliases to Toradex DTS
Message-ID: <20231206013737.GA236001@dragon>
References: <20231120205818.33120-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120205818.33120-1-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:58:15PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add mmc aliases to ensure a consistent mmc device naming across the
> Toradex SoM family, with this commit mmc0 is the on-module eMMC
> boot device and the not available mmc interfaces are removed.
> 
> Hiago De Franco (3):
>   ARM: dts: imx6qdl-apalis: Add usdhc aliases
>   ARM: dts: imx6qdl-colibri: Add usdhc aliases
>   ARM: dts: imx7d-colibri-emmc: Add usdhc aliases

Applied all, thanks!
