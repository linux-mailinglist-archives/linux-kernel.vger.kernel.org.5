Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719B3772884
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjHGPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHGPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:03:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7810FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691420585;
        bh=kNVEUFAVbS7sLP87QPT3dDszG0RMz4xD/Y9tyFDq03g=;
        h=Message-ID:Date:MIME-Version:Subject:To:From;
        b=aBLzsGz0vmMZnH9IoRpJ6eMl7pdwtxUk/6VOMJRZdjN+hjd7zFPO30+zFTaZgNLau
         /HEECMlKfoLpGbQ4rwfDqmvbGRl10nUjLY/P6evo8zcJnhPc1dNvszJaMu3tnzPG8+
         14t5RzDeJqL3vCwG8TZ6RnEtLrEn0/9kNRthziP0=
X-QQ-mid: bizesmtp65t1691420492tlem05vv
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 23:01:20 +0800 (CST)
X-QQ-SSF: 01400000000000803000000A0000000
X-QQ-FEAT: vLOCICHxEeDuURQkrq4byYu69a2AxguMzD+YTtCk31skVC+RB3e/NzUVuEsKY
        o3uR5vLOje3vb56E15ctcOVyd6F8mfwZqWNGTu1AN7XXEMzrLsUpt6jpGtXj8Xs8KVUV2GD
        Um8qkcAo4uY0beuH86GJ25VjvJt7eb9zu3np1/0B6GJzJ3vJ/A7333Ojbs2y3dBgzgc2gNk
        Hj2mUYM6IdQJbwgoSChlUD1OWhYUvR6qsi50EWgCKr2Ale9Ytx/k178AYpdSceQDFK9n0S3
        luF/vzOg9EJksY+uHIV2lgvKGUBY/0EW30BrO/k80VwMTrLNKp2jFp8+vMuf2ifaC7IQPUQ
        VNlwL6+HWe+BnfrdOb6PBZnJvtAnj4Kac+hQHclC6C2ygio3hhCTdazg06nGoKhmL6YdBjj
        90t5wjGEKTA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10160666789589212089
Message-ID: <A5FB84817C757588+1d5864c8-7059-5195-1f3a-617015f3e9ab@biqu3d.com>
Date:   Mon, 7 Aug 2023 17:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
Content-Language: en-US
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <09BFA974F83AB0E8+20230807145349.2220490-5-martin@biqu3d.com>
From:   Martin Botka <martin@biqu3d.com>
In-Reply-To: <09BFA974F83AB0E8+20230807145349.2220490-5-martin@biqu3d.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mark it but no changes from v3 in this patch.

On 8/7/23 4:53 PM, Martin Botka wrote:
> The BigTreeTech Pi is an H616 based board based on CB1.
> Just in Rpi format board.
> 
> It features the same internals as BTT CB1 but adds:
>      - Fan port
>      - IR receiver
>      - ADXL345 Accelerometer connector via SPI
>      - 24V DC power supply via terminal plugs
>      - USB to CAN module connector (The actual USB to CAN happens on the external module)
> 
> List of currently working things is same as BTT CB1 but also:
>      - IR receiver
>      - ADXL345 connector
> 
> Signed-off-by: Martin Botka <martin@biqu3d.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changes in V2:
>      - Add UART alongside aliases and chosen for it
>      - Add model string
>      - Enable IR receiver
>      - Enable SPI0 for ADXL345 connector
> Changes in V3:
>      - Add missing semicolons
>      - Add pinctrl for SPI0
> 
>   arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 70 +++++++++++++++++++
>   2 files changed, 71 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 7b386428510b..0b6232a7f328 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> new file mode 100644
> index 000000000000..b0d0386e8f13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> +
> +/ {
> +	model = "BigTreeTech Pi";
> +	compatible = "bigtreetech,pi", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&ohci3 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	/* SPI connection for onboard connector for ADXL345 accelerometer */
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
