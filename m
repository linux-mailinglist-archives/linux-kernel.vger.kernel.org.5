Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAB758F88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGSHuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGSHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67130E60;
        Wed, 19 Jul 2023 00:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBFFA60F13;
        Wed, 19 Jul 2023 07:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F834C433C7;
        Wed, 19 Jul 2023 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689752998;
        bh=nDc7tloAZwzUUh5UUTM7WdwtwFHDVwDK/LJcSuBuH5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krl/89WcrRTjmG6fyQ78wZm2awMGEd0GI9i+/TP6fmdCN2ymqFnEWe1TVgCMBDXPe
         azxxXR8eb6uoqBWDcW0mBveu89sifTiO07hlIpQRM+zVmBaLbYCo6joTxW03WQONq4
         75J4eKwoTC3RBRn/TrqvUcvrvO2uro7rSUQItSGuIm59ehlSTkZSdxOuPSLpSvru9Y
         XMuL+qybbLFPOOIYNBp0h9ImYJnpwMFBlBL0l4kAkXBs9bodZXJxq7g8XPlVLrRQUL
         MryENJ1XOc6CHDy49RMyjWmjvn7goAitC9WQ6YvHDCikDvy5luBFNb1RWdstyRBoti
         nNhQrKC8zFlQg==
Date:   Wed, 19 Jul 2023 15:49:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH v3 2/3] arm64: dts: freescale: add initial device tree
 for MBa93xxLA SBC board
Message-ID: <20230719074947.GN151430@dragon>
References: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
 <20230718085722.1198862-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085722.1198862-3-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:57:21AM +0200, Alexander Stein wrote:
> This adds support for TQMa93xx module and MBa93xxLA SBC board.
> TQMa93xx is a SOM using i.MX93 SOC. The SOM features PMIC, RAM, e-MMC and
> some optional peripherals like SPI-NOR, RTC, EEPROM, gyroscope and
> secure element.
> TQMa93xxLA is a solder on type SOM and can be used directly on MBa93XXLA.
> TQMa93xxCA is a feature compatible, socketable type SOM.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!
