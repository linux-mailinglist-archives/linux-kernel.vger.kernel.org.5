Return-Path: <linux-kernel+bounces-23574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B382AE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31F91F2816D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E897A15ACD;
	Thu, 11 Jan 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aKhl99aq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D917156F3;
	Thu, 11 Jan 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F6E7896;
	Thu, 11 Jan 2024 13:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704975475;
	bh=UyrD6JFTO3THsOc0NwrLYt/hWeSjSzysWC0BvTLbJ9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aKhl99aqbg8X9uJF84Imt7ngI9YBkK+PfijqOOUtelk2FJ+NgvkupU6/FYmisjhU6
	 uXOihyHRRaciLowIJ7DC43EGu9Lo1hy96AjXtaftnCHb4aLmEfVWiKKbq8VAC4nBQR
	 KWDuLCsHBCZ5TcZaXd+YiE8fuCpj0W3c8K9XrxqY=
Message-ID: <720246cf-cba0-43c4-ac55-879012dc27d3@ideasonboard.com>
Date: Thu, 11 Jan 2024 14:18:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] arm64: dts: ti: k3-am65: Add MIT license along with
 GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Rob Herring <robh@kernel.org>,
 Tony Lindgren <tony@atomide.com>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-7-nm@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240110140903.4090946-7-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 16:08, Nishanth Menon wrote:
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
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Tony Lindgren <tony@atomide.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi                     | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                      | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                   | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am65.dtsi                          | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am652.dtsi                         | 4 ++--
>   .../dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso     | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts               | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso                  | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am654-idk.dtso                     | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi      | 5 ++++-
>   arch/arm64/boot/dts/ti/k3-am654.dtsi                         | 4 ++--
>   11 files changed, 24 insertions(+), 21 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index fcea54465636..e55a8c891bc9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM6 SoC Family Main Domain peripherals
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   #include <dt-bindings/phy/phy-am654-serdes.h>
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index ecd7356f3315..6ff3ccc39fb4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM6 SoC Family MCU Domain peripherals
>    *
> - * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_mcu {
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index f037b36243ce..37527890ddea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_wakeup {
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index 4d7b6155a76b..c59baebc5a25 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM6 SoC Family
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/ti/k3-am652.dtsi b/arch/arm64/boot/dts/ti/k3-am652.dtsi
> index 0f22e00faa90..cbb3caaf82c3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am652.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am652.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM65 SoC family in Dual core configuration
>    *
> - * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include "k3-am65.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> index 4209d991eb6b..364c57b3b3a0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> @@ -1,10 +1,10 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /**
>    * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
>    * Panel Link: https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT
>    * AM654 LCD EVM: https://www.ti.com/tool/TMDSLCD1EVM
>    *
> - * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 822c288d2797..5109e1bf68d0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -1,6 +1,6 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
> - * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> index ec8cf20ca3ac..0a6e75265ba9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /**
>    * DT overlay for IDK application board on AM654 EVM
>    *
> - * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> index 150428dfce6f..8bdb87fcbde0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /**
>    * DT overlay for IDK application board on AM654 EVM
>    *
> - * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> index 9021c738056b..de5a2ed907a7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> @@ -1,4 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
>   
>   #include <dt-bindings/thermal/thermal.h>
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> index 888567b921f0..bb77c8454734 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> @@ -1,8 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
>    * Device Tree Source for AM6 SoC family in Quad core configuration
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include "k3-am65.dtsi"


