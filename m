Return-Path: <linux-kernel+bounces-24947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5082C523
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4F11C2262F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC217C9B;
	Fri, 12 Jan 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n3wiSLAW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4D1AAA3;
	Fri, 12 Jan 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CHwjdV078929;
	Fri, 12 Jan 2024 11:58:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705082325;
	bh=PhIGoUQlM+uURwcXlMwuAoVz4y5y+HTbgDHxL0fF+zU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=n3wiSLAWcZx+ECcnA37ns0laYc8I3NhqmaIFXaFj8UfIrsEbaG1dx854YVrdWb+7X
	 rxxAMCagIT7KZT6osPswwJux/rNarqRVS7a37p9aDqemyEkJ+58+5l+71/wQ+zV7zQ
	 2Ls0IJHrLkuYQdUa7UuUrJocGcWoOx/K4d4pwUks=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CHwjnM030811
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jan 2024 11:58:45 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 11:58:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 11:58:45 -0600
Received: from [10.249.40.136] ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CHwimu048633;
	Fri, 12 Jan 2024 11:58:44 -0600
Message-ID: <c1ea65a6-4aad-4ca1-88cf-ac3fa130b0e4@ti.com>
Date: Fri, 12 Jan 2024 11:58:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: hummingboard-t: add descriptions
 for m.2 pci-e and usb-3
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-5-1385246c428c@solid-run.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240112-add-am64-som-v2-5-1385246c428c@solid-run.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/12/24 11:12 AM, Josua Mayer wrote:
> HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
> The single SerDes lane of the SoC can be routed to either M1 pci-e
> signals, or M2 usb-3 signals by a gpio-controlled mux.
> 
> Add dedicated dts for each configuration.
> - k3-am642-hummingboard-t.dts enables neither configuration
> - k3-am642-hummingboard-t-pcie.dts (new)
>    configures serdes mux and pci-e controller for M1
> - k3-am642-hummingboard-t-usb3.dts (new)
>    configures serdes mux and usb-3 controller for M2
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile                    |  2 ++
>   .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dts   | 31 ++++++++++++++++++
>   .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dts   | 37 ++++++++++++++++++++++
>   3 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 041c3b71155e..0e408555edf1 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -33,6 +33,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
>   # Boards with AM64x SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
> new file mode 100644
> index 000000000000..5ba0029fcfb9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + * DTS for SolidRun AM642 HummingBoard-T,
> + * running on Cortex A53, with PCI-E.
> + *
> + */
> +
> +#include "k3-am642-hummingboard-t.dts"

Avoid including .dts files, if this file is for an option that
can be chosen (PCIe vs USB3), then it should be a DT overlay.

> +#include "k3-serdes.h"
> +
> +/ {
> +	model = "SolidRun AM642 HummingBoard-T with PCI-E";
> +};
> +
> +&pcie0_rc {
> +	status = "okay";

If PCIe is only available here when using this add-on then
all of the node data should be in this add-on file.

Andrew

> +};
> +
> +&serdes0_link {
> +	cdns,phy-type = <PHY_TYPE_PCIE>;
> +};
> +
> +&serdes_ln_ctrl {
> +	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
> +};
> +
> +&serdes_mux {
> +	idle-state = <1>;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
> new file mode 100644
> index 000000000000..12b0fedcd2bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + * DTS for SolidRun AM642 HummingBoard-T,
> + * running on Cortex A53, with USB-3.1 Gen 1.
> + *
> + */
> +
> +#include "k3-am642-hummingboard-t.dts"
> +#include "k3-serdes.h"
> +
> +/ {
> +	model = "SolidRun AM642 HummingBoard-T with USB-3.1 Gen 1";
> +};
> +
> +&serdes0_link {
> +	cdns,phy-type = <PHY_TYPE_USB3>;
> +};
> +
> +&serdes_ln_ctrl {
> +	idle-states = <AM64_SERDES0_LANE0_USB>;
> +};
> +
> +&serdes_mux {
> +	idle-state = <0>;
> +};
> +
> +&usbss0 {
> +	/delete-property/ ti,usb2-only;
> +};
> +
> +&usb0 {
> +	maximum-speed = "super-speed";
> +	phys = <&serdes0_link>;
> +	phy-names = "cdns3,usb3-phy";
> +};
> 

