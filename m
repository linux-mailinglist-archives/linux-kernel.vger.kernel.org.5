Return-Path: <linux-kernel+bounces-15738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1F82310F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E89B223E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0A1B29C;
	Wed,  3 Jan 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LnFBHPZv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165851B28E;
	Wed,  3 Jan 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1704298514; x=1704903314; i=wahrenst@gmx.net;
	bh=imkSH+hwXFfzyiK1yfUX4mKbDgZe9g8ZcJZYzgf+QN0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LnFBHPZvNDAHvvJw7iqXyQ6bIUF1n/r/YoY1i+NMdrtudncZYAHhXl+ETV2gLbFx
	 mz14VLFg7lFxnx4ruV3hbj8UBPAS5p7AWZYFXd5+xzdZFCTv2JP9wqf7ntzTB8TPn
	 F3xW0GzDfNbeEYhLX+AKvmqaEhV7wsBxaJV/Tbt5rPgybWSj8PJb07GbGZpVO+sxO
	 +YHIwPFUutPkrenqPKXpwTp8mMal7zIKIL9xCls7IoXW+/NWqSicO8kHDHkk4brsG
	 6gpOa9T4dU8g+FabSHc2lnAdhRQsonEH4g7Nhp+5sqQ99tWPx1sdJ7iQvTPjrv7xx
	 GuoHTZo8BO6LQZf0Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1reNTA09fy-00LWIg; Wed, 03
 Jan 2024 17:15:14 +0100
Message-ID: <2a2dda53-754b-4aa4-8457-9fc37310c267@gmx.net>
Date: Wed, 3 Jan 2024 17:15:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Li Yang <leoyang.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
References: <20240103143639.32280-1-othacehe@gnu.org>
 <20240103143639.32280-3-othacehe@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240103143639.32280-3-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LymS0Usi2/IByK7faB7lS4yWXu/28nZy8fN6LdxyePNkl4y4Dm1
 Uhoeyn5JYpB+HyaDt8FZt9bwX/gxFD3umRL5fyplqNv/z0gyubLMY/PEFoCNPDubqR+dVzE
 49c6/bfUtcVKvUAx9k33RhSVDKLiqYtKBFCjwOL+yeLavCu9S27DyTpm8bcbODYkSQXDI8p
 sTjSKq4zzx+RBnzbE+ZAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yi/3E2Kk6ac=;UKVyhY9iJfUBgwQXdMGS44Wjnwo
 CQZtMd39Qr5+1laS0Ede9k06JwNmgg/Gbcz6FZ/gXWxYylocWSeuGLYnOSQuFVYV4gaUZgy2p
 15VN1I2j54K99iW4CiE1ZJT/sZFpaNzDAHxWv/nPW13gerp2Gfd9HF9zXUwvNy+KQ9pu0Nip5
 RMT/MI6h2LVbog1ZZ2t2NnJpn7bx/MqxrptqCEH8mVIsriYYn/93dDx4KdvaquiYe8/mbiyia
 44KvtgZvst2nfsPcNxj8+2BdGXXOdSCNTKfq7izGh1LTJDMapcOc9WVzmmcJN4oa7rxGL1OHB
 vb/UXQYbzO9WeGKs2x82x2WuKo6VvBNM2Louw+5B/HRQWjbRKC9sHViv6jtBm8BPqvW+8gYGZ
 F+sRTl9AVSZ5U1UU0EnvfHcPXO887RsHcjL3m0z788JNWT+c34hhmers2zJrPpnIPiIC27exC
 R6nUx9px90S++vrCdEf3xCTYLzNhV3Eje/UJ9hQy/K0lQpc0rtzMjfuA2YzzjSA65u9K2qBf6
 vxaFqmtaSAW0dnT5P1eMKXCU4WaEdWlCwn5bjvW9V+vIKtoM+vQZVZFVmNL1j8ZYS7r/0i+lv
 7KjT3XiSK/V4FkcR/6Owub2AUmWXNo94EvwP+kQGsgrekMtoD7t6GbzLc8z3EaauBbaFPG42X
 iU27ySCGRBnbkeLmXKrDqvTWv0JsmBOd2ioUyIvUFhIUgHywGkmqpnH3JocX1zhWNKOl9pMx1
 7yayQOzzHOgc2UQOwL8lm5pUGd4ID19ml/lzpwi8sg1I40m+5dxnnQXlvI1yN9bS1mDt9SJCV
 mKWPCg9FYB7xNdtzLrdCZm8BrvMvCBShK/iEgEhCcYv21b0uDR/0WWc5vL7tujKKXAWYEWG/k
 MxTXdfr0RqJPTbDGb72h4V3wfXAjYCms6oEk51waZp7f73UVsg6JMDA+w0cchNdtltinz9C/H
 dUh9/aVQ/S5GJFP3f5D+2qJ4P2Y=

Hi Mathieu,

Am 03.01.24 um 15:36 schrieb Mathieu Othacehe:
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
>   .../dts/freescale/imx93-var-som-symphony.dts  | 352 ++++++++++++++++++
>   .../boot/dts/freescale/imx93-var-som.dtsi     | 111 ++++++
>   3 files changed, 464 insertions(+)
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
> index 000000000000..963fa1a6d09c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> @@ -0,0 +1,352 @@
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
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		key-back {
> +			label =3D "Back";
> +			gpios =3D <&pca9534 1 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_BACK>;
> +		};
> +
> +		key-home {
> +			label =3D "Home";
> +			gpios =3D <&pca9534 2 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_HOME>;
> +		};
> +
> +		key-menu {
> +			label =3D "Menu";
> +			gpios =3D <&pca9534 3 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_MENU>;
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		status =3D "okay";
> +
> +		heartbeat {
Please use a node name, which describe the hardware in general like "led".
> +			label =3D "Heartbeat";
The label property is deprecated, please use function and color instead:

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bi=
ndings/leds/common.yaml

Best regards
> +			gpios =3D <&pca9534 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};
> +};
> +

