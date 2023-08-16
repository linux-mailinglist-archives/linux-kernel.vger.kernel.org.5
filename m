Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7775977DABE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbjHPGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjHPGyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:54:47 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4181BCC;
        Tue, 15 Aug 2023 23:54:45 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G4gLd5026291;
        Wed, 16 Aug 2023 08:54:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=rOjor1O0+ig6x7t9FGtOGQthnaKBxVrqga54n11aiSg=; b=gO
        jftjL04i9doCW+11nldbpxfZSepBBVMud65Mhf05oNJRR3R2NTYt9gPVNKEtyy3H
        fCxsXCTwDHu7QpKhVHbcueVIZXs31U3lJSGDSkxn3wSnMiGD1IXDl4gCnbsy1ZA/
        5te1q/m5sfoesUmvXIe6/5NsVt51LRdqY4gATiTw8ij4VvWBOYyulx7RBF1AX2Ji
        3ug0zg2+lIRtNRMn0KbisuN8hiMW9bKjBffdQ0FgVvIWdcDeJMS5k/fJeu7tktJX
        MC5RjwabsEOWZktBtCZDPMwZ8QBLM2pPZLm7vvgc5Mvj5ELM/dk6ZSKdEyBUhh+a
        9Hd+X9tdhnr4uf8Ohg6g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgqnt8jub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:54:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F61E100068;
        Wed, 16 Aug 2023 08:54:18 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8470A216ED2;
        Wed, 16 Aug 2023 08:54:18 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 08:54:17 +0200
Message-ID: <e6afc5bb-7477-36d6-b05b-2afdd1107f03@foss.st.com>
Date:   Wed, 16 Aug 2023 08:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] ARM: dts: st: stih407: drop max-duty-cycle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
 <20230730174954.5293-4-krzysztof.kozlowski@linaro.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230730174954.5293-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_04,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/23 19:49, Krzysztof Kozlowski wrote:
> "max-duty-cycle" property was removed in the commit f747a1fe7848
> ("regulator: pwm-regulator: Remove obsoleted property"):
> 
>   stih418-b2199.dtb: pwm-regulator: Unevaluated properties are not allowed ('max-duty-cycle' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Correct subject prefix: AMR->ARM
> ---
>  arch/arm/boot/dts/st/stih407-family.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
> index 3f58383a7b59..29302e74aa1d 100644
> --- a/arch/arm/boot/dts/st/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/st/stih407-family.dtsi
> @@ -111,7 +111,6 @@ pwm_regulator: pwm-regulator {
>  		regulator-min-microvolt = <784000>;
>  		regulator-max-microvolt = <1299000>;
>  		regulator-always-on;
> -		max-duty-cycle = <255>;
>  		status = "okay";
>  	};
>  


Applied on sti-next

Thanks
Patrice
