Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881287B60FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjJCGua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:50:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386BAC;
        Mon,  2 Oct 2023 23:50:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3936oEqA028164;
        Tue, 3 Oct 2023 01:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696315814;
        bh=PHw2VJStHwNbxtflNaARse8dp+y9yTz3uZ4RUV46/wE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FNZvmk8TnNORKrQo/uGExuDZnWGiydgVktV33Q6/nAPPtp6Gh1YpGJ/eWOAYDZCx9
         i3wacSzSrrslxuWWt6F3NApC2Mclt0wmosoWIi+KCpxfEuNmNVgGJpEErAL0CQejHC
         Sgt9doSatLx/puF3N1IWJSE2yxhTBqWamBbl81Oo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3936oEWU126591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 01:50:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 01:50:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 01:50:14 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3936oAVS078003;
        Tue, 3 Oct 2023 01:50:11 -0500
Message-ID: <4eb50f24-b6c8-790e-91b0-5646ebbb2d10@ti.com>
Date:   Tue, 3 Oct 2023 12:20:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 2/7] arm64: dts: ti: k3-j784s4: Add ESM instances
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230927023357.9883-1-j-keerthy@ti.com>
 <20230927023357.9883-3-j-keerthy@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230927023357.9883-3-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/23 08:03, Keerthy wrote:
> Patch adds the ESM instances for j784s4. It has 3 instances.
> One in the main domain and two in the mcu-wakeup domian.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  8 ++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index efed2d683f63..26dc3776f911 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1568,4 +1568,12 @@
>  		firmware-name = "j784s4-c71_3-fw";
>  		status = "disabled";
>  	};
> +
> +	main_esm: esm@700000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x700000 0x00 0x1000>;
> +		ti,esm-pins = <688>, <689>, <690>, <691>, <692>, <693>, <694>,
> +			      <695>;
> +		bootph-pre-ram;

Similar to other nodes in this file, here and elsewhere use
		bootph-all


> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 4ab4018d3695..a7b5c4cb7d3e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -700,4 +700,18 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	mcu_esm: esm@40800000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x40800000 0x00 0x1000>;
> +		ti,esm-pins = <95>;
> +		bootph-pre-ram;
> +	};
> +
> +	wkup_esm: esm@42080000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x42080000 0x00 0x1000>;
> +		ti,esm-pins = <63>;
> +		bootph-pre-ram;
> +	};
>  };

-- 
Regards
Vignesh
