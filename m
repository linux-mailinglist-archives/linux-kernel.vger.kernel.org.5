Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0277F77FF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355150AbjHQVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355151AbjHQVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:05:36 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E82C3592
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=cyiHqxPewOUpiLCgGfyzAGcRUj6oFW1nQmFKoVsPlwg=;
        b=We1DvlBHISgTXv7m8zEcddU4iaI3+XfhW/TnucIxIffh7qASLlT8cIDlmR6a1o9WqrTD
        4PWhu9Nr49a3liMAglWKJUFKaojc6uYLbMg2EP+bgp/wbwfWOSINr5OpWB8cpVRRDNboLg
        2rAFk6X07A7TAuVnm5ugqUAecQ2cJF6h1PLkWgECQhoeYsPhgfH/dy7M6FRZ6mlJ1XWmrr
        i6f++GVH2FtdbPbuKQK7oXT/SoRzTtsWuzMFHFq3HB299n0EWxqlm9ucxegt2SviUA0P3S
        W2QH0d0uQ9bCSgKAjlQi3cncFgapqcytp6RdkTdIdFZV8j6kLZiYlzzzg4J3MV7A==
Received: by filterdrecv-65f68489c8-qxj4s with SMTP id filterdrecv-65f68489c8-qxj4s-1-64DE8B9E-3
        2023-08-17 21:05:34.1068273 +0000 UTC m=+8544571.152719573
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-4 (SG) with ESMTP
        id wpz1daj1Q02vwM5bH70FAA
        Thu, 17 Aug 2023 21:05:33.924 +0000 (UTC)
Message-ID: <c187cd65-b3fc-1ebb-86f9-cc41fe7512f3@kwiboo.se>
Date:   Thu, 17 Aug 2023 21:05:34 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Content-Language: en-US
References: <cover.1692102057.git.efectn@6tel.net>
 <a1eca379d151c3f91f4cd4e1751ba389096c4f13.1692102057.git.efectn@6tel.net>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a1eca379d151c3f91f4cd4e1751ba389096c4f13.1692102057.git.efectn@6tel.net>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyCiVY7Rd6FCVJxn9?=
 =?us-ascii?Q?YKn6BxeQGSlAokbdSAyYThKQkTnDSrOvFFgJA3p?=
 =?us-ascii?Q?LQHf163Os1yOJ8tkSFUilxG4VYIFwQsgViA14Oi?=
 =?us-ascii?Q?hkHs+RYAQ9RcRJHI+icDtRIvgEFWxiJ0AozWXgf?=
 =?us-ascii?Q?KA3IE3y1x8xJuEdCTYoNySCRs7vSzie=2F448SrF?=
To:     Muhammed Efe Cetin <efectn@6tel.net>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-15 14:59, Muhammed Efe Cetin wrote:
> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
> Sdmmc, SPI Flash, PMIC.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 873 ++++++++++++++++++
>  1 file changed, 873 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> new file mode 100644
> index 000000000000..85071084a207
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> @@ -0,0 +1,873 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +

[...]

> +
> +&sfc {
> +	pinctrl-0 = <&fspim0_pins>;
> +	pinctrl-names = "default";
> +	max-freq = <100000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	spi_flash: spi-flash@0 {

Node should be named flash@0 to help SPI flash boot with U-Boot.

Regards,
Jonas

> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			loader@0 {
> +				label = "loader";
> +				reg = <0x0 0x1000000>;
> +			};
> +		};
> +	};
> +};
> +

[...]

