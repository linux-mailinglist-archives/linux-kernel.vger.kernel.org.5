Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E27708F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHDTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHDTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:22:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165811BE;
        Fri,  4 Aug 2023 12:22:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 374JMWhr117737;
        Fri, 4 Aug 2023 14:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691176952;
        bh=ZPr5/mVFtaKQIXxLL1Lwkt1hpyKhH9CHkOiSQjC0/gM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xhtwjb0KaJmSW/3Gpm+MAHmDF1VFHf/J6Du0mAMy+RBZWAY21/SS3szyyof0OwE7p
         XL/KtEKGIZORXneP8UDqKt1rwqqor+aGKaR8tXCtPhtN8ELrwA4rBshWdnIv41VfT2
         M9wvLTTRJpVmxU02inm8DCAH+Hlu4dmBALP8LGKI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 374JMWLm031490
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 14:22:32 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 14:22:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 14:22:31 -0500
Received: from [10.249.132.69] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 374JMQX1021939;
        Fri, 4 Aug 2023 14:22:27 -0500
Message-ID: <9f19e01e-6211-16eb-c911-998ee2d46161@ti.com>
Date:   Sat, 5 Aug 2023 00:52:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v9 4/5] arm64: dts: ti: k3-j784s4-evm: Enable
 DisplayPort-0
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-5-j-choudhary@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230803080441.367341-5-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh,


On 03-Aug-23 13:34, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Enable display for J784S4 EVM.
> 
> Add assigned clocks for DSS, DT node for DisplayPort PHY and pinmux for
> DP HPD. Add the clock frequency for serdes_refclk.
> 
> Add the endpoint nodes to describe connection from:
> DSS => MHDP => DisplayPort connector.
> 
> Also add the GPIO expander-4 node and pinmux for main_i2c4 which is
> required for controlling DP power. Set status for all required nodes
> for DP-0 as "okay".
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> [j-choudhary@ti.com: move all the changes together to enable DP-0 in EVM]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 119 +++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 7ad152a1b90f..005357d70122 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -249,6 +249,28 @@ vdd_sd_dv: regulator-TLV71033 {
>  		states = <1800000 0x0>,
>  			 <3300000 0x1>;
>  	};
> +
> +	dp0_pwr_3v3: regulator-dp0-prw {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dp0-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	dp0: connector-dp0 {
> +		compatible = "dp-connector";
> +		label = "DP0";
> +		type = "full-size";
> +		dp-pwr-supply = <&dp0_pwr_3v3>;
> +
> +		port {
> +			dp0_connector_in: endpoint {
> +				remote-endpoint = <&dp0_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &main_pmx0 {
> @@ -286,6 +308,19 @@ vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>  			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
>  		>;
>  	};
> +
> +	dp0_pins_default: dp0-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0cc, PIN_INPUT, 12) /* (AM37) SPI0_CS0.DP0_HPD */
> +		>;
> +	};
> +
> +	main_i2c4_pins_default: main-i2c4-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
> +			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
> +		>;
> +	};
>  };
>  
>  &wkup_pmx2 {
> @@ -827,3 +862,87 @@ adc {
>  		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>  	};
>  };
> +
> +&serdes_refclk {
> +	status = "okay";
> +	clock-frequency = <100000000>;
> +};
> +
> +&dss {
> +	status = "okay";
> +	assigned-clocks = <&k3_clks 218 2>,
> +			  <&k3_clks 218 5>,
> +			  <&k3_clks 218 14>,
> +			  <&k3_clks 218 18>;
> +	assigned-clock-parents = <&k3_clks 218 3>,
> +				 <&k3_clks 218 7>,
> +				 <&k3_clks 218 16>,
> +				 <&k3_clks 218 22>;
> +};
> +
> +&serdes_wiz4 {
> +	status = "okay";
> +};
> +
> +&serdes4 {
> +	status = "okay";
> +	serdes4_dp_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <4>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_DP>;
> +		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
> +			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
> +	};
> +};
> +
> +&mhdp {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp0_pins_default>;
> +	phys = <&serdes4_dp_link>;
> +	phy-names = "dpphy";
> +};
> +
> +&dss_ports {
> +	port {

Port index has not been added here. Since this port outputs to MHDP
bridge, this should be "port@0", and a "reg = <0>;" property should be
added below (along with the address and size cells properties).

I suppose this works functionally in this case, because the port gets
defaulted to "0" by the driver. But in future, when we add support for
other dss output(s) on j784s4-evm, the driver will need indices to
distinguish among them.

> +		dpi0_out: endpoint {
> +			remote-endpoint = <&dp0_in>;
> +		};
> +	};
> +};
> +
> +&main_i2c4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c4_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp4: gpio@20 {
> +		compatible = "ti,tca6408";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&dp0_ports {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

These properties are being repeated from the MHDP node in the main.dtsi
file, in the previous patch. You can drop them from one of the places.

I would suggest keeping them in the main.dtsi file and removing them
here, so that repetition is avoided across different platform.dts files,
but I will leave the call up to you. In any case, they need to be
removed from one of the two places.

Btw, same will be applicable for dss_ports as well (once you add port
index). Separate address and size cells properties won't be required in
the j784s4-evm.dts and am69-sk.dts platform files, once they are already
there in j784s4-main.dtsi.

With the changes suggested above,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> +
> +	port@0 {
> +		reg = <0>;
> +
> +		dp0_in: endpoint {
> +			remote-endpoint = <&dpi0_out>;
> +		};
> +	};
> +
> +	port@4 {
> +		reg = <4>;
> +
> +		dp0_out: endpoint {
> +			remote-endpoint = <&dp0_connector_in>;
> +		};
> +	};
> +};

