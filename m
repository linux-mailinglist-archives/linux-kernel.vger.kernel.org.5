Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4A76F073
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjHCROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHCROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:14:48 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628171BF0;
        Thu,  3 Aug 2023 10:14:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373HEXXO106561;
        Thu, 3 Aug 2023 12:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691082873;
        bh=M+NDSflbEljMlPMn2zaVb2eVzIkgjG0cGkjKNzfiloA=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=SmRgAJQnoSrHJP3JmEzMjsAGqOB1gq5vuBaHbdg3hQ6SS+/fvOUfiRtiWs9mBZCjL
         2xd6+owGiAa6XctxaxK8TkOh2pTdt4IyGjBDmSJzJX0pr/TrjCmN/5/P4KfCHD56jl
         71VcvjphPvwck2zbvzXfnO41V12rk/oNknSVm6Fw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373HEXiX120868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 12:14:33 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 12:14:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 12:14:32 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373HESVF015124;
        Thu, 3 Aug 2023 12:14:29 -0500
Message-ID: <80daaf47-02b8-a48d-904e-28d0445a6118@ti.com>
Date:   Thu, 3 Aug 2023 22:44:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721s2: Correct pinmux offset for
 ospi
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sinthu.raja@ti.com>, <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>
References: <20230803145655.806001-1-u-kumar1@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230803145655.806001-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit,

Thank you for fixing this,

On 03/08/23 20:26, Udit Kumar wrote:
> Due to non-addressable regions in J721S2 SOC wkup_pmx was split
> into four regions from wkup_pmx0 to wkup_pmx3.
> 
> After split while updating the pin mux references to newly defined
> four wkup_pmx, pin mux for OSPI0 was left.
> Pin mux for OSPI0 is spread over two range wkup_pmx0
> and wkup_pmx1, correcting pin mux for ospi and
> adding correct pin mux setting within ospi node.
> 
> Also correcting OSPI1 pinmux which falls under wkup_pmx1
> along with removing unused MCU_OSPI1_CSn1 pin for OSPI.
> 
> Fixes: 6bc829ceea41 ("arm64: dts: ti: k3-j721s2: Fix wkup pinmux range")
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> 
> Logs with v3
> https://gist.github.com/uditkumarti/6c8b1b1a0bc0bcfef5e04de37c3cb411
> 
> dtbs_check run after applying https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/
> 
> Change log:
> 
> Changes in v3:
>   - Corrected wkup_pmx for ospi1
>   - Removed unused pin MCU_OSPI1_CSn1, shared with pmic 
>   - v2: https://lore.kernel.org/all/20230802113500.162276-1-u-kumar1@ti.com/
> 
> Changes in v2:
>   - Changed name of pin mux to align with
>   https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/ patch
>   - v1: https://lore.kernel.org/all/20230801125626.3287306-1-u-kumar1@ti.com/
> 
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 19 ++++++++++---------
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 13 ++++++++++---
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index 02b7a559bdf2..88e80996f56b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -250,18 +250,19 @@ J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (N26) MCU_ADC1_AIN6 */
>  			J721S2_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (N27) MCU_ADC1_AIN7 */
>  		>;
>  	};
> +};
>  
> +&wkup_pmx1 {
>  	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
>  		pinctrl-single,pins = <
> -			J721S2_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
> -			J721S2_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
> -			J721S2_WKUP_IOPAD(0x060, PIN_OUTPUT, 0) /* (C21) MCU_OSPI1_CSn1 */
> -			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
> -			J721S2_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
> -			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
> -			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
> -			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
> -			J721S2_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
> +			J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
> +			J721S2_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
> +			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
> +			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
> +			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
> +			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
> +			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
> +			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
>  		>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> index d57dd43da0ef..fd1d6c884736 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> @@ -45,8 +45,6 @@ mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
>  			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
>  			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
>  			J721S2_WKUP_IOPAD(0x030, PIN_OUTPUT, 0) /* (G17) MCU_OSPI0_CSn1 */

CS1 can be dropped as it is not being used.

> -			J721S2_WKUP_IOPAD(0x038, PIN_OUTPUT, 0) /* (F14) MCU_OSPI0_CSn2 */
> -			J721S2_WKUP_IOPAD(0x03c, PIN_OUTPUT, 0) /* (F17) MCU_OSPI0_CSn3 */
>  			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
>  			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
>  			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
> @@ -61,6 +59,15 @@ J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
>  	};
>  };
>  
> +&wkup_pmx1 {
> +	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F14) MCU_OSPI0_CSn2 */
> +			J721S2_WKUP_IOPAD(0x004, PIN_OUTPUT, 0) /* (F17) MCU_OSPI0_CSn3 */

These are unused, there is only a single device on CS0, it looks like when
support for OSPI was added for J721S2, all CS pinmux was being configured even
though it was not needed. Since you are fixing it, it would be best to drop
unused ones so that there are no future conflicts.

Thanks and Regards,
Vaishnav


> +		>;
> +	};
> +};
> +
>  &wkup_pmx2 {
>  	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>  		pinctrl-single,pins = <
> @@ -127,7 +134,7 @@ &main_mcan16 {
>  &ospi0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
>  
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
