Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FF7814DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjHRVm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbjHRVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:42:01 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CF421E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=OLmq1haPDidESsRMW3IYy2CuAsD11e/Ixo/HNO+zhyc=;
        b=qCfUrKtOrd296UM0Oi6DGGV6T1ovKmMOMNPKvBj42ktBWe/Z2bZcB7+up891i6CjghVk
        hKNDuVXEFnDdC5bag1ZQZJ6rfHjF1vngBna+08CNPH91TSDzEJoBXd3dxlKmtZ5f33Fz9U
        wcQT2c9y77P7yH3amTdIh+7XsIfDc6QOdRVfRGRXPuoFr2X6HiUxeJeRw3vcL2EW5PN7Z4
        XW0efOMGXt5xXMt7KmMcup9TkAK7MvHMPSxcneuXEpB/Xn8JnTHe3sQHOvzWBYWknptscB
        9FNKhuV3+tyaKaok2/O2ShoqGLx8jiFFPv01/0TExtnvTKA6hCsG2/o49PEZiJkw==
Received: by filterdrecv-66949dbc98-2h875 with SMTP id filterdrecv-66949dbc98-2h875-1-64DFE588-11
        2023-08-18 21:41:28.455880717 +0000 UTC m=+8632909.379319801
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-7 (SG) with ESMTP
        id bCMqnjtxT7aDkWs7EeqkYQ
        Fri, 18 Aug 2023 21:41:28.096 +0000 (UTC)
Message-ID: <6a968e28-bb98-cf99-82bf-7154249e77ed@kwiboo.se>
Date:   Fri, 18 Aug 2023 21:41:28 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: Add sfc node to rk3588s
Content-Language: en-US
References: <cover.1692372351.git.efectn@6tel.net>
 <a7b640b9c1fe163a72183af04d089bd19326bfa8.1692372351.git.efectn@6tel.net>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a7b640b9c1fe163a72183af04d089bd19326bfa8.1692372351.git.efectn@6tel.net>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2e6gkSy9sC0u9mAe?=
 =?us-ascii?Q?v8+o8dpwDxJ2rwoxu+oPBQZyN2z9ssOkJf9ykQG?=
 =?us-ascii?Q?P=2FAQNekTOvhCMqhOxWMdJDqszgbwDbU0PeX8Vku?=
 =?us-ascii?Q?fVV4cDpLi8duhxpX5zbAglMC8s64eZ=2FyeDHTtdn?=
 =?us-ascii?Q?egBApsIXG6e8r7kgUK4hDp2OL+6ZYbF=2FE6WxrX?=
To:     Muhammed Efe Cetin <efectn@6tel.net>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com, megi@xff.cz
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-18 18:05, Muhammed Efe Cetin wrote:
> Add sfc node to rk3588s.dtsi from downstream kernel.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 5544f66c6ff4..3c753f9b8acc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1424,6 +1424,18 @@ sata-port@0 {
>  		};
>  	};
>  
> +	sfc: spi@fe2b0000 {
> +		compatible = "rockchip,sfc";
> +		reg = <0x0 0xfe2b0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> +		clock-names = "clk_sfc", "hclk_sfc";
> +		assigned-clocks = <&cru SCLK_SFC>;

assigned-clocks should also be removed now that assigned-clock-rates was
removed.

Regards,
Jonas

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	sdmmc: mmc@fe2c0000 {
>  		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x0 0xfe2c0000 0x0 0x4000>;

