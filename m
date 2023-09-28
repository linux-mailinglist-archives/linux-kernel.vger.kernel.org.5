Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD287B189F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjI1KwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjI1KwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:52:06 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A1199;
        Thu, 28 Sep 2023 03:52:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38SApdDT010995;
        Thu, 28 Sep 2023 05:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695898299;
        bh=yQ23yP/4dLIZZYBzgjMWswPX30FCFAgk9cKsBV41l1w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m5ODKqDG5onzNxq/eWYNosvJKXhxGK4K9GBtgPrZxKvOYPw5sUxVzLmIc3XDWp9wQ
         8U638e914wJ1FuQiCJABqJKYcrctXxxxRPL/Z6ZmsIb/OFYpdPEUiG9E+KQ75tDBtC
         jezhpFs3N96g557+2STN2iI/STq0TXTieMBVgfE4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38SApd4a056756
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 05:51:39 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 05:51:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 05:51:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38SApcig093586;
        Thu, 28 Sep 2023 05:51:39 -0500
Date:   Thu, 28 Sep 2023 16:21:37 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Muhammed Efe Cetin <efectn@6tel.net>
CC:     <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <heiko@sntech.de>, <sebastian.reichel@collabora.com>,
        <jonas@kwiboo.se>, <megi@xff.cz>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Add Orange Pi 5
Message-ID: <20230928105137.5ljhuoxjc7et5thw@dhruva>
References: <cover.1692632346.git.efectn@6tel.net>
 <1dac46f3d6d4b4a1b2621534da0bdde9a9cf777c.1692632346.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dac46f3d6d4b4a1b2621534da0bdde9a9cf777c.1692632346.git.efectn@6tel.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Aug 21, 2023 at 18:47:59 +0300, Muhammed Efe Cetin wrote:
> Add initial support for OPi5 that includes support for USB2, PCIe2, Sata,
> Sdmmc, SPI Flash, PMIC.
> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> Reviewed-by: Ondřej Jirman <megi@xff.cz>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 673 ++++++++++++++++++
>  2 files changed, 674 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> 
...

Can you provide some sort of documentation on how I can build and boot
the kernel on this board? I was unable to use the upstream arm64
defconfig with this exact series applied to boot the board.

> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m3_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;

Are you able to actually use rtc as a wakeup source? I tried this
on a downstream kernel that I mention below..

rtcwake -s 10 -m mem

didn't actually seem to wake the device from deepsleep after 10 seconds.
Do you know what other pins I can use as wakeup sources?

> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";

Just wondering, can you please give some logs of the board with eth
working? The image that I have from opi seems to fail eth? As in I am
not able to see any ip address. here are the logs:

https://gist.github.com/DhruvaG2000/eda2762e35013c8d5ac9f37e818103a3

...

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
