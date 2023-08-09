Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609B07763A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjHIP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjHIP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:27:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408BE7C;
        Wed,  9 Aug 2023 08:27:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379FRVIM015029;
        Wed, 9 Aug 2023 10:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691594851;
        bh=zkzq2syJAEiKOiYak5vE+juk3OiRR7uW4s60nLsjIlU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IHt2eztvZTCS6+PUk6/XNfW1OIWmk5Nx7wybysAkcKP0fr3VlSXMbzUBimp7MxauE
         quLs5g4T/RJ0BXrPE2oYw9R8hqtk0p/H5RjhS1Hvt74yJ9hhXoc8oGmtYqlItojIOi
         wnQKFl2rgmZpB22OGKYKDTxjKba+A64OrOv5k294=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379FRV3X015969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 10:27:31 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 10:27:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 10:27:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379FRUAE003853;
        Wed, 9 Aug 2023 10:27:30 -0500
Date:   Wed, 9 Aug 2023 10:27:30 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v5 4/6] arm64: dts: ti: k3-j784s4-evm: Fix interrupt
 ranges for TPS6594 PMIC
Message-ID: <20230809152730.6pbb4fze6pv55gye@trapper>
References: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
 <20230809-tps6594-v5-4-485fd3d63670@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809-tps6594-v5-4-485fd3d63670@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$subject is wrong.

On 20:17-20230809, Jai Luthra wrote:
> From: Apelete Seketeli <aseketeli@baylibre.com>
> 
> This patch fixes the interrupt range for TPS6594 PMIC on MCU/WAKEUP
> domain for RTC peripheral.
> 
This needs to be rephrased - interrupt map for gpio wakeup interrupt
controller is mapped in-correctly rather than indicating what caught the
bug in the SoC description.

Also missing:

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")

> Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 740ee794d7b9..77a45f97e28b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -107,7 +107,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
>  		#interrupt-cells = <1>;
>  		ti,sci = <&sms>;
>  		ti,sci-dev-id = <177>;
> -		ti,interrupt-ranges = <16 928 16>;
> +		ti,interrupt-ranges = <16 960 16>;
>  	};
>  
>  	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
> 
> -- 
> 2.41.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
