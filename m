Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6A758F64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGSHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGSHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:44:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6501BF5;
        Wed, 19 Jul 2023 00:43:32 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R5STg2rjnz18Lgs;
        Wed, 19 Jul 2023 15:42:47 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 19 Jul
 2023 15:43:30 +0800
Message-ID: <64B79421.80007@hisilicon.com>
Date:   Wed, 19 Jul 2023 15:43:29 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: hisilicon: Fix "status" values
References: <20230626221019.3946448-1-robh@kernel.org>
In-Reply-To: <20230626221019.3946448-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2023/6/27 6:10, Rob Herring wrote:
> The defined value for "status" is "disabled", not "disable".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to the HiSilicon arm32 dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hisilicon/hi3519.dtsi | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hisilicon/hi3519.dtsi b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
> index c524c854d319..a42b71cdc5d7 100644
> --- a/arch/arm/boot/dts/hisilicon/hi3519.dtsi
> +++ b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
> @@ -54,7 +54,7 @@ uart0: serial@12100000 {
>  			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg HI3519_UART0_CLK>, <&crg HI3519_UART0_CLK>;
>  			clock-names = "uartclk", "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		uart1: serial@12101000 {
> @@ -63,7 +63,7 @@ uart1: serial@12101000 {
>  			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg HI3519_UART1_CLK>, <&crg HI3519_UART1_CLK>;
>  			clock-names = "uartclk", "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		uart2: serial@12102000 {
> @@ -72,7 +72,7 @@ uart2: serial@12102000 {
>  			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg HI3519_UART2_CLK>, <&crg HI3519_UART2_CLK>;
>  			clock-names = "uartclk", "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		uart3: serial@12103000 {
> @@ -81,7 +81,7 @@ uart3: serial@12103000 {
>  			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg HI3519_UART3_CLK>, <&crg HI3519_UART3_CLK>;
>  			clock-names = "uartclk", "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		uart4: serial@12104000 {
> @@ -90,7 +90,7 @@ uart4: serial@12104000 {
>  			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg HI3519_UART4_CLK>, <&crg HI3519_UART4_CLK>;
>  			clock-names = "uartclk", "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		dual_timer0: timer@12000000 {
> @@ -100,7 +100,7 @@ dual_timer0: timer@12000000 {
>  			reg = <0x12000000 0x1000>;
>  			clocks = <&clk_3m>;
>  			clock-names = "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		dual_timer1: timer@12001000 {
> @@ -110,7 +110,7 @@ dual_timer1: timer@12001000 {
>  			reg = <0x12001000 0x1000>;
>  			clocks = <&clk_3m>;
>  			clock-names = "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		dual_timer2: timer@12002000 {
> @@ -120,7 +120,7 @@ dual_timer2: timer@12002000 {
>  			reg = <0x12002000 0x1000>;
>  			clocks = <&clk_3m>;
>  			clock-names = "apb_pclk";
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		spi_bus0: spi@12120000 {
> @@ -132,7 +132,7 @@ spi_bus0: spi@12120000 {
>  			num-cs = <1>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		spi_bus1: spi@12121000 {
> @@ -144,7 +144,7 @@ spi_bus1: spi@12121000 {
>  			num-cs = <1>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		spi_bus2: spi@12122000 {
> @@ -156,7 +156,7 @@ spi_bus2: spi@12122000 {
>  			num-cs = <1>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		sysctrl: system-controller@12020000 {
> 
