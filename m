Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDCB77197C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHGFep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHGFel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:34:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58681703;
        Sun,  6 Aug 2023 22:34:37 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3775YVVb039374;
        Mon, 7 Aug 2023 00:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691386471;
        bh=4t66MrV+ljNnXe0vcSZjFevJgZ7Pm6Uz07sEsTJbfS8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UXN2OWSfouwdtZjn74WSAURRLhJshiM1qZ2WNAp3ZnJO8cE2tV/AR+3oGNPsu+zv1
         TS8O1nJAPYvvdc7UiNsjD6Gt0BJSkg5Z80m5UNlwh3f90jfzA/iz2lXakt9nCSgCo/
         4XlpUTNf7fhnfldN6vqo003YOjx8OZ/1RBGksRmI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3775YVjW003788
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 00:34:31 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 00:34:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 00:34:31 -0500
Received: from [172.24.227.68] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3775YRQq039099;
        Mon, 7 Aug 2023 00:34:28 -0500
Message-ID: <20ecae96-2a44-49ce-a88e-c81f64b3fcb0@ti.com>
Date:   Mon, 7 Aug 2023 11:04:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/13] arm64: dts: ti: k3-j721s2: Enable GPIO nodes at the
 board level
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-10-afd@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230802205309.257392-10-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/23 02:23, Andrew Davis wrote:
> GPIO nodes defined in the top-level J721s2 SoC dtsi files are incomplete
> and may not be functional unless they are extended with pinmux and
> device information.
> 
> Disable the GPIO nodes in the dtsi files and only enable the ones that
> are actually pinned out on a given board.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   .../boot/dts/ti/k3-am68-sk-base-board.dts      | 18 ++----------------
>   .../dts/ti/k3-j721s2-common-proc-board.dts     | 18 ++++++------------
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi     |  4 ++++
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi      |  2 ++
>   4 files changed, 14 insertions(+), 28 deletions(-)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index ffca12df0a6da..4c855dffb4cd2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -297,31 +297,17 @@ J721S2_WKUP_IOPAD(0x000, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
>   };
>   
>   &main_gpio0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
>   };
>   
> -&main_gpio2 {
> -	status = "disabled";
> -};
> -
> -&main_gpio4 {
> -	status = "disabled";
> -};
> -
> -&main_gpio6 {
> -	status = "disabled";
> -};
> -
>   &wkup_gpio0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_rpi_header_gpio0_pins0_default>, <&mcu_rpi_header_gpio0_pins1_default>;
>   };
>   
> -&wkup_gpio1 {
> -	status = "disabled";
> -};
> -
>   &wkup_uart0 {
>   	status = "reserved";
>   	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index 3a8e6eb402448..6f248d27a30a4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -266,20 +266,14 @@ J721S2_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
>   	};
>   };
>   
> -&main_gpio2 {
> -	status = "disabled";
> -};
> -
> -&main_gpio4 {
> -	status = "disabled";
> -};
> -
> -&main_gpio6 {
> -	status = "disabled";
> +&main_gpio0 {
> +	status = "okay";
> +	/* default pins */
>   };
>   
> -&wkup_gpio1 {
> -	status = "disabled";
> +&wkup_gpio0 {
> +	status = "okay";
> +	/* default pins */
>   };
>   
>   &wkup_uart0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index c46079fe4ed6e..0cc8057fce13c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -507,6 +507,7 @@ main_gpio0: gpio@600000 {
>   		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 111 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_gpio2: gpio@610000 {
> @@ -523,6 +524,7 @@ main_gpio2: gpio@610000 {
>   		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 112 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_gpio4: gpio@620000 {
> @@ -539,6 +541,7 @@ main_gpio4: gpio@620000 {
>   		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 113 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_gpio6: gpio@630000 {
> @@ -555,6 +558,7 @@ main_gpio6: gpio@630000 {
>   		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 114 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_i2c0: i2c@2000000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 736ec5fa0ea28..3557f3338377d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -323,6 +323,7 @@ wkup_gpio0: gpio@42110000 {
>   		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 115 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	wkup_gpio1: gpio@42100000 {
> @@ -339,6 +340,7 @@ wkup_gpio1: gpio@42100000 {
>   		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 116 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	wkup_i2c0: i2c@42120000 {

-- 
Thanks and Regards,
Dhruva Gole
