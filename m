Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2581B75ACDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGTLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:19:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993DABE;
        Thu, 20 Jul 2023 04:19:56 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R69Dr5MbTzrRnZ;
        Thu, 20 Jul 2023 19:19:08 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 19:19:54 +0800
Message-ID: <64B91859.8060407@hisilicon.com>
Date:   Thu, 20 Jul 2023 19:19:53 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: add missing space before {
References: <20230705145925.293447-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705145925.293447-1-krzysztof.kozlowski@linaro.org>
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

Hi Krzysztof,

On 2023/7/5 22:59, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi  | 8 ++++----
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi  | 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index f29a3e471288..be808bb2544e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -861,7 +861,7 @@ tsensor: tsensor@0,f7030700 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		i2s0: i2s@f7118000{
> +		i2s0: i2s@f7118000 {
>  			compatible = "hisilicon,hi6210-i2s";
>  			reg = <0x0 0xf7118000 0x0 0x8000>; /* i2s unit */
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* 155 "DigACodec_intr"-32 */
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> index c588848bfdeb..f46c33d10750 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> @@ -570,7 +570,7 @@ port@5 {
>  			};
>  		};
>  
> -		eth0: ethernet-4{
> +		eth0: ethernet-4 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <4>;
> @@ -579,7 +579,7 @@ eth0: ethernet-4{
>  			dma-coherent;
>  		};
>  
> -		eth1: ethernet-5{
> +		eth1: ethernet-5 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <5>;
> @@ -588,7 +588,7 @@ eth1: ethernet-5{
>  			dma-coherent;
>  		};
>  
> -		eth2: ethernet-0{
> +		eth2: ethernet-0 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <0>;
> @@ -597,7 +597,7 @@ eth2: ethernet-0{
>  			dma-coherent;
>  		};
>  
> -		eth3: ethernet-1{
> +		eth3: ethernet-1 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <1>;
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> index 595abe339c5d..81d907ef43ed 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> @@ -1483,7 +1483,7 @@ port@5 {
>  			};
>  		};
>  
> -		eth0: ethernet@4{
> +		eth0: ethernet@4 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <4>;
> @@ -1492,7 +1492,7 @@ eth0: ethernet@4{
>  			dma-coherent;
>  		};
>  
> -		eth1: ethernet@5{
> +		eth1: ethernet@5 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <5>;
> @@ -1501,7 +1501,7 @@ eth1: ethernet@5{
>  			dma-coherent;
>  		};
>  
> -		eth2: ethernet@0{
> +		eth2: ethernet@0 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <0>;
> @@ -1510,7 +1510,7 @@ eth2: ethernet@0{
>  			dma-coherent;
>  		};
>  
> -		eth3: ethernet@1{
> +		eth3: ethernet@1 {
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <1>;
> 
