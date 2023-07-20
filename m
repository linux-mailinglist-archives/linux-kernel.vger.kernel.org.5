Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAF75ACD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGTLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:19:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B8269F;
        Thu, 20 Jul 2023 04:19:32 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R69BP2R1GzLnlt;
        Thu, 20 Jul 2023 19:17:01 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 19:19:29 +0800
Message-ID: <64B91840.6040801@hisilicon.com>
Date:   Thu, 20 Jul 2023 19:19:28 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: minor whitespace cleanup around
 '='
References: <20230702185308.44544-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702185308.44544-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2023/7/3 2:53, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index b7e2cbf466b3..f29a3e471288 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -1032,17 +1032,17 @@ mali: gpu@f4080000 {
>  			compatible = "hisilicon,hi6220-mali", "arm,mali-450";
>  			reg = <0x0 0xf4080000 0x0 0x00040000>;
>  			interrupt-parent = <&gic>;
> -			interrupts =	<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			interrupt-names = "gp",
>  					  "gpmmu",
> 
