Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774DE7814ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbjHRVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbjHRVyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:54:16 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92A3C2F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=qeXAbHvNitTFm4cEy03EvZZa2UPZe6OGwywOZibvvjM=;
        b=Ic+M+DTWya+c2KGKgZMxF18ywtY01nCEyeCkL+Q+gDU2MVoV/i0YSqTLMncc5VYNfu9r
        KYbLUZlba3jdCjJGmjSAboag8uAQFPI3HRdHJKDvK6oxlwaAGlQlnThdbx88Ad6FTA6Kfc
        JrGh87wP4wfQvi+6o9ayiy1PgUpcG8ItJRh6Y+A4cEgY6qvLnLG+9eHFf2PvUvcWGRtX4K
        OUHS2YA5MOS2uQPNtcRfNnvQFOLJUgtiJYIkft9AoKykvVg7wBLQgl7jRbfLrqpCH+50ld
        UabCmJ3FEuMw+suTMUhJrZwBQntBjBJW4r8bfGCa5VwkoYXW6/brg6QVazOcwVGA==
Received: by filterdrecv-84b96456cb-5hl7m with SMTP id filterdrecv-84b96456cb-5hl7m-1-64DFE885-7
        2023-08-18 21:54:13.415450006 +0000 UTC m=+8633757.384197490
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-6 (SG) with ESMTP
        id cPUyzc9dQ4SEYPR19RR_gw
        Fri, 18 Aug 2023 21:54:13.157 +0000 (UTC)
Message-ID: <23e9beba-92cf-4f89-a8a9-49e6d83aacc3@kwiboo.se>
Date:   Fri, 18 Aug 2023 21:54:13 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Orange Pi 5
Content-Language: en-US
References: <cover.1692372351.git.efectn@6tel.net>
 <201e8df24c3a2f25c13d3f1d129f8be4fe2eb97a.1692372351.git.efectn@6tel.net>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <201e8df24c3a2f25c13d3f1d129f8be4fe2eb97a.1692372351.git.efectn@6tel.net>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7acr64auAJIdVSfd?=
 =?us-ascii?Q?JfNj8LCzOOTJYbb7HIT2GhOxWYwywFIGennykEL?=
 =?us-ascii?Q?HoHPtVx5otYbY3ofWaJ8eD5gaFX016ke=2F09cXyf?=
 =?us-ascii?Q?nFPNsqX6IyPjh7yOFl8kX6zUZo0rMJ6z11jREQz?=
 =?us-ascii?Q?EH9VXodumNs2NaavekJCr3=2F3WjK7zamvBXxbOp?=
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-18 18:05, Muhammed Efe Cetin wrote:
> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
> Sdmmc, SPI Flash, PMIC.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 687 ++++++++++++++++++
>  2 files changed, 688 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index e7728007fd1b..c29386106b7a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -105,3 +105,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> new file mode 100644
> index 000000000000..f396b1285d73
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> @@ -0,0 +1,687 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +

[...]

> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +	pinctrl-names = "default";
> +	snps,reset-gpio = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 20000 100000>;

snps,reset props are deprecated, use reset-gpios in rgmii_phy1.

> +	tx_delay = <0x42>;
> +	status = "okay";
> +};
> +

[...]

> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +	};
> +};
> +

[...]

> +
> +&sfc {
> +	pinctrl-0 = <&fspim0_pins>;
> +	pinctrl-names = "default";
> +	max-freq = <100000000>;

This prop is not used, drop it.

> +	#address-cells = <1>;
> +	#size-cells = <0>;

You already have #address-cells and #size-cells in rk3588s.dtsi.

> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;

spi- props should be in alphabetical order, rx before tx.

> +		#address-cells = <1>;
> +		#size-cells = <0>;

You can also drop #address-cells and #size-cells here.

Regards,
Jonas

> +	};
> +};
> +

[...]

