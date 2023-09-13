Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7E79EBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbjIMOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbjIMOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:50:12 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58571AF;
        Wed, 13 Sep 2023 07:50:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DEnjxJ105094;
        Wed, 13 Sep 2023 09:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694616585;
        bh=3kzN+eWiLMMqqT68k/QUtOeybIa03pmbjistamBKdXA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=k4U5zLAMCAMqoBvJViKMPR4Wyu5+gLl3VSgwdw8ljLtMuIVvznYxA87JzozjaobjX
         l9VtYEiZ1YlyxTaLuD9HmxzSIjbxXoj5ncifBSZNXwHHUp1nL3H0jNe7pJ2ApEOd0F
         jkB2BJ1/sgn5DOy+hh8Bfm851OGAlr+lXhYnqm4o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DEnjad072702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 09:49:45 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 09:49:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 09:49:45 -0500
Received: from [128.247.81.19] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DEnj37088462;
        Wed, 13 Sep 2023 09:49:45 -0500
Message-ID: <64a4a0a8-7628-ffee-fca0-c7b953769fa6@ti.com>
Date:   Wed, 13 Sep 2023 09:49:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am65: Add full compatible to
 dss-oldi-io-ctrl node
To:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911142556.64108-1-afd@ti.com>
 <20230911142556.64108-2-afd@ti.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230911142556.64108-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/23 09:25, Andrew Davis wrote:
> This matches the binding for this register region which fixes a couple
> DTS check warnings.
> 
> While here trim the leading 0s from the "reg" definition.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

For both the patches, 1/2 and 2/2,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index bc460033a37a8..d5f217427893d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -498,8 +498,8 @@ serdes_mux: mux-controller {
>  		};
>  
>  		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
> -			compatible = "syscon";
> -			reg = <0x000041e0 0x14>;
> +			compatible = "ti,am654-dss-oldi-io-ctrl", "syscon";
> +			reg = <0x41e0 0x14>;
>  		};
>  
>  		ehrpwm_tbclk: clock-controller@4140 {
