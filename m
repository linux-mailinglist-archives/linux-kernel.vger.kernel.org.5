Return-Path: <linux-kernel+bounces-25731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966E82D50F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A261F219B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4563B6;
	Mon, 15 Jan 2024 08:28:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90995C98;
	Mon, 15 Jan 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 643A02F4;
	Mon, 15 Jan 2024 00:29:05 -0800 (PST)
Received: from [10.34.100.129] (unknown [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6313F5A1;
	Mon, 15 Jan 2024 00:28:16 -0800 (PST)
Message-ID: <49356b25-771b-4b42-acd6-c5fae95f0bef@arm.com>
Date: Mon, 15 Jan 2024 09:28:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT license along
 with GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Panis <jpanis@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Ronald Wahl <ronald.wahl@raritan.com>,
 Sarah Walker <sarah.walker@imgtec.com>, Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-4-nm@ti.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240110140903.4090946-4-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
For all the patches of the serie that require it:
Acked-by: Pierre Gondois <pierre.gondois@arm.com>

On 1/10/24 15:08, Nishanth Menon wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
> 
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).
> 
> Cc: Guillaume La Roque <glaroque@baylibre.com>
> Cc: Julien Panis <jpanis@baylibre.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Sarah Walker <sarah.walker@imgtec.com>
> Cc: Tony Lindgren <tony@atomide.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                 | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                  | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi              | 5 ++++-
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi               | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62.dtsi                      | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am625-sk.dts                   | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am625.dtsi                     | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi           | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso      | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso      | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso       | 4 ++--
>   13 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> index 5e6feb8cd125..c4149059a4c5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * AM62x LP SK: https://www.ti.com/tool/SK-AM62-LP
>    *
> - * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 464b7565d085..fe0cc4a9a501 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM625 SoC Family Main Domain peripherals
>    *
> - * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_main {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> index 0e0b234581c6..e66d486ef1f2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM625 SoC Family MCU Domain peripherals
>    *
> - * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_mcu {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
> index a358757e26f0..12ba833002a1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
> @@ -1,4 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
>   
>   #include <dt-bindings/thermal/thermal.h>
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index fef76f52a52e..a0bba5ddd409 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM625 SoC Family Wakeup Domain peripherals
>    *
> - * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_wakeup {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> index f1e15206e1ce..f0781f2bea29 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM62 SoC Family
>    *
> - * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index b18092497c9a..ae81ebb39d02 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * AM625 SK: https://www.ti.com/lit/zip/sprr448
>    *
> - * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> index 4193c2b3eed6..4014add6320d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> @@ -1,10 +1,10 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM625 SoC family in Quad core configuration
>    *
>    * TRM: https://www.ti.com/lit/pdf/spruiv7
>    *
> - * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 33768c02d8eb..05b762602a65 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Common dtsi for AM62x SK and derivatives
>    *
> - * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/leds/common.h>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> index 6f4cd73c2f43..76ca02127f95 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> @@ -1,7 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * IMX219 (RPi v2) Camera Module
> - * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> index 9323a4b38389..ccc7f5e43184 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> @@ -1,7 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
> - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> index dcaa33a4c8d3..4eaf9d757dd0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> @@ -1,7 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
> - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
> index 08eb2e894bbc..18c3082f68e6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /**
>    * Audio playback via HDMI for AM625-SK and AM62-LP SK.
>    *
> @@ -6,7 +6,7 @@
>    * AM625 SK: https://www.ti.com/tool/SK-AM62
>    * AM62-LP SK: https://www.ti.com/tool/SK-AM62-LP
>    *
> - * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;

