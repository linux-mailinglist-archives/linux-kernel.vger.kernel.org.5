Return-Path: <linux-kernel+bounces-12855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B481FB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8161C22021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15237107B9;
	Thu, 28 Dec 2023 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Nm3BiNnm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0610A02;
	Thu, 28 Dec 2023 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703796371; x=1704401171; i=wahrenst@gmx.net;
	bh=T0mk2YAaxXtSiEcL2Ny8pGwFUQdrZdy6SKEjDXl1gho=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Nm3BiNnmXmRjIR3cU/8caY2pkukAhUjcTsYZ0H8rdO5AY3Mgs2jpEtteAvh4nw1J
	 5PCSCl4QSvKyNHx21B5ksKVD+QVYLz4ihllSRhA40TJ7eJEDPwl/VsYxmJedGz2aq
	 5nvGsws749VPM+Ktm5jU1ws3EyhKUTua5dQCqd9MnKZD2heduYToReLbBPlMvvSoh
	 TQvchqRdRRSXZPLWHaaveup+/fctECnK30mtfdPHbJmU68BuRq9G+8peibsyAAkO0
	 8unLV1ZcANKdkknCBeIKcVhpXJA0+AygsPN83KZRtkmOYCIPSa/kXpe9VbwEhxbDw
	 l5h6mxTu757lyTT4XA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1rBsqY2uXh-016jUG; Thu, 28
 Dec 2023 21:46:11 +0100
Message-ID: <d378ad67-2a75-4a14-a131-7eb91de9ad3d@gmx.net>
Date: Thu, 28 Dec 2023 21:46:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
To: Mathieu Othacehe <othacehe@gnu.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231227170919.8771-1-othacehe@gnu.org>
 <20231227170919.8771-3-othacehe@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231227170919.8771-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L7kl1gh1jnNmjxg2va/CXkFeEwLP37Z5qLrwRWS38xn2wo8Wh/y
 K7bbvNHceeV6yhXKC2YFAsLEvQK67KKAj6r5+vk30oqYP/s0Bg/yHkFR7xz8DMn1ApyAPiv
 o2Lb+AZls3Yoi8co6c/y/WpYZMzY4uYWLjlQRIjZSWrRQiq5nBgT2d96BRQbph75PSGyOFR
 pDX3MhN0oPqndfONWPfTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xZlJywniXpM=;gzb6nLdtEtsMVRMfmBlJs1GNV70
 BsgJdaA0wAGrF8S2JjkLo/wuM3EVFvRheNqK9nwbuHZdtS3MgIn+Xbro6h205xqpZjZxUDi2f
 6CIzyOPumEw7u1YXVf69FMGg9du3Nd/hztnnCISKTdlCLwkgutcglf3M4VzWmlvjy4MNCJKwM
 PMY1ilTV5KwgUNfEzAubaUxe6nM/p0ugchb9vm8yVzLmQNJ1hWc5MWU1G8LNfKTzMrqQTdnAH
 dG7LEHFdpmSJKlHibZBvr34Gc8/b+LH3hTDTbr/wOAapd4mmqEuhi15rDWvekBhg7EQXNCijA
 vZvPiO16GL6dYkqsSRboNQ5dx2q1GtorO4vbIcb4Uo7lzDaVmq+K5UbyIimdBk3+m/M8+HODB
 6C7QzRoWQ/crK8HOlBcsw4ZMUyIH25Gmz1Y5vKRzW00iFsa4n8qdH60v+Jj9cFmAz1pkKxjK8
 mloR9NtAt/n5uC8bYx+wPr/V71egD/pFaGPZlfClMtdZ5UHyzVjt7sEZtGp7L+7lwj5YMifY+
 zQltiCKYVKq2VpUaGFPvXT0KY4+PN7j5PFq0UP/RNSjRRr6QgI7PJy73e/I0llA+z/iNxMCZl
 ZSzTJRk3LriIqx6VHvXDiKTeCkMg9Lxg6IOekKsciHzT4rW0Xu03hbxQzgrqqtKFxpLBzPe0+
 GgboGjEjYJaIOv4vRdSXf91s+1UvSR1UFq9lS0F4SmaXrrX2E83aKVgQl71ILbiMo7NbjU1ug
 WFP0/Gr+AKCs8H1OYE1rzuClLJPb3hxKu0RTIZGEwRsD3UuvXFFXqaNK3V8ZR6YdeswUgbmKh
 OeU5EyRdAAF+QLKlXlxrsl8H1PhWl/yqYoJZyRGH3P5n9wNHMjc8hT8OpvcaZu/uUKRagkQBw
 /CQ3rIXM1mxtsQbRamxE5yxCUsgYGgt4HNdq3rzcqy8xQ6ZAL1IHiljWjTXDt+WNFRCTPEiXN
 710YSuxOicFWD+AtRxJnQ5ch/fKFRPLsCh7k4TBsYhIWEEF1

Hi Mathieu,

Am 27.12.23 um 18:09 schrieb Mathieu Othacehe:
> Add DTSI for Variscite VAR-SOM-MX93 System on Module and DTS for Varisci=
te
> VAR-SOM-MX93 on Symphony evaluation board.
>
> This version comes with:
> - NXP i.MX 93 Dual, 1.7GHz, Cortex-A55 + Cortex-M33
> - 2 GB of RAM
> - 16GB eMMC
> - 802.11ax/ac/a/b/g/n WiFi with 5.3 Bluetooth
> - CAN bus
> - Audio codec
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>   .../dts/freescale/imx93-var-som-symphony.dts  | 303 ++++++++++++++++++
>   .../boot/dts/freescale/imx93-var-som.dtsi     | 111 +++++++
>   3 files changed, 415 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphon=
y.dts
>   create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dt=
s/freescale/Makefile
> index 2e027675d7bb..a6f1700961e3 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-var-som-symphony.dtb
>
>   imx8mm-venice-gw72xx-0x-imx219-dtbs	:=3D imx8mm-venice-gw72xx-0x.dtb i=
mx8mm-venice-gw72xx-0x-imx219.dtbo
>   imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:=3D imx8mm-venice-gw72xx-0x.dtb i=
mx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/=
arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> new file mode 100644
> index 000000000000..3b7a01fb1b51
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93-var-som.dtsi"
> +
> +/{
> +	model =3D "Variscite VAR-SOM-MX93 on Symphony evaluation board";
> +	compatible =3D "variscite,var-som-mx93-symphony",
> +		     "variscite,var-som-mx93", "fsl,imx93";
> +
> +	aliases {
> +		ethernet0 =3D &eqos;
> +		ethernet1 =3D &fec;
> +	};
> +
> +	chosen {
> +		stdout-path =3D &lpuart1;
> +	};
> +
> +	/*
> +	 * Needed only for Symphony <=3D v1.5
> +	 */
> +	reg_fec_phy: regulator-fec-phy {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fec-phy";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-enable-ramp-delay =3D <20000>;
> +		gpio =3D <&pca9534 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name =3D "VSD_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&gpio2 18 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us =3D <20000>;
> +		enable-active-high;
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vref_1v8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		ethosu_mem: ethosu-region@88000000 {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			reg =3D <0x0 0x88000000 0x0 0x8000000>;
> +		};
> +
> +		vdev0vring0: vdev0vring0@87ee0000 {
> +			reg =3D <0 0x87ee0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@87ee8000 {
> +			reg =3D <0 0x87ee8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: vdev1vring0@87ef0000 {
> +			reg =3D <0 0x87ef0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: vdev1vring1@87ef8000 {
> +			reg =3D <0 0x87ef8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		rsc_table: rsc-table@2021f000 {
> +			reg =3D <0 0x2021f000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: vdevbuffer@87f00000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x87f00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		ele_reserved: ele-reserved@87de0000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x87de0000 0 0x100000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +/* Use external instead of internal RTC*/
> +&bbnsm_rtc {
> +	status =3D "disabled";
> +};
> +
> +&eqos {
> +	mdio {
> +		ethphy1: ethernet-phy@5 {
> +			compatible =3D "ethernet-phy-ieee802.3-c22";
> +			reg =3D <5>;
> +			qca,disable-smarteee;
> +			eee-broken-1000t;
> +			reset-gpios =3D <&pca9534 5 GPIO_ACTIVE_LOW>;
> +			reset-assert-us =3D <10000>;
> +			reset-deassert-us =3D <20000>;
> +			vddio-supply =3D <&vddio1>;
> +
> +			vddio1: vddio-regulator {
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +			};
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_fec>;
> +	phy-mode =3D "rgmii";
> +	phy-handle =3D <&ethphy1>;
> +	phy-supply =3D <&reg_fec_phy>;
> +	status =3D "okay";
> +};
> +
> +&flexcan1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan1>;
> +	status =3D "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_fec: fecgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
> +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
> +			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
> +			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
> +			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_PDM_CLK__CAN1_TX                       0x139e
> +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX               0x139e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1_gpio: lpi2c1gpiogrp {
> +		fsl,pins =3D <
> +			MX93_PAD_I2C1_SCL__GPIO1_IO00			0x31e
> +			MX93_PAD_I2C1_SDA__GPIO1_IO01			0x31e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c5: lpi2c5grp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
> +			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO23__GPIO2_IO23			0x31e
> +			MX93_PAD_GPIO_IO22__GPIO2_IO22			0x31e
> +		>;
> +	};
> +
> +	pinctrl_pca9534: pca9534grp {
> +		fsl,pins =3D <
> +			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO18__GPIO2_IO18		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +};
> +
> +&lpi2c1 {
> +	clock-frequency =3D <400000>;
> +	pinctrl-names =3D "default", "sleep", "gpio";
> +	pinctrl-0 =3D <&pinctrl_lpi2c1>;
> +	pinctrl-1 =3D <&pinctrl_lpi2c1_gpio>;
> +	pinctrl-2 =3D <&pinctrl_lpi2c1_gpio>;
> +	scl-gpios =3D <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +	sda-gpios =3D <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +	status =3D "okay";
> +
> +	/* DS1337 RTC module */
> +	rtc@68 {
> +		compatible =3D "dallas,ds1337";
> +		reg =3D <0x68>;
> +	};
> +};
> +
> +&lpi2c5 {
> +	clock-frequency =3D <400000>;
> +	pinctrl-names =3D "default", "sleep", "gpio";
> +	pinctrl-0 =3D <&pinctrl_lpi2c5>;
> +	pinctrl-1 =3D <&pinctrl_lpi2c5_gpio>;
> +	pinctrl-2 =3D <&pinctrl_lpi2c5_gpio>;
> +	scl-gpios =3D <&gpio2 23 GPIO_ACTIVE_HIGH>;
> +	sda-gpios =3D <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +	status =3D "okay";
> +
> +	pca9534: gpio@20 {
> +		compatible =3D "nxp,pca9534";
> +		reg =3D <0x20>;
> +		gpio-controller;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_pca9534>;
> +		interrupt-parent =3D <&gpio3>;
> +		interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
> +		#gpio-cells =3D <2>;
> +		wakeup-source;
> +	};
there are neither gpio-line-names defined for this GPIO expander nor the
SOC. Are there no GPIOs which can be accessed from userspace?

Best regards

