Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1FF7723D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHGMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjHGMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:25:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4BE68;
        Mon,  7 Aug 2023 05:25:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377COwhf071896;
        Mon, 7 Aug 2023 07:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691411098;
        bh=T6bZ3w5eVHmvRyJS+UbRDhf5yNILgFgKffL9h8y+Cmk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UOqjKyY6w2usgIXhj/xFP3Lt+9d/Tqnf5DtEYpjHqKbQx5j4I6Pt2oHYJZZuM/uwj
         6uy7heiROOa0BDThU6cdHjV6FQ1FOpvKdC+F8mhjsZ1B7FnTMGzWc7yoS9p59QVitu
         3c4FezhVwA5sGyNMvCbc+Udw69YqradQzp0cLn7o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377COwbP002405
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 07:24:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 07:24:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 07:24:57 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377COrQS020506;
        Mon, 7 Aug 2023 07:24:53 -0500
Message-ID: <2ddc34f9-92ad-9a0c-8044-0ec671e55e9e@ti.com>
Date:   Mon, 7 Aug 2023 17:54:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 4/5] arm64: dts: ti: k3-j784s4-evm: Enable
 DisplayPort-0
To:     Aradhya Bhatia <a-bhatia1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>,
        <rogerq@kernel.org>
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-5-j-choudhary@ti.com>
 <9f19e01e-6211-16eb-c911-998ee2d46161@ti.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <9f19e01e-6211-16eb-c911-998ee2d46161@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aradhya,

Thank you for the review.

On 05/08/23 00:52, Aradhya Bhatia wrote:
> Hi Jayesh,
> 
> 
> On 03-Aug-23 13:34, Jayesh Choudhary wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> Enable display for J784S4 EVM.
>>
>> Add assigned clocks for DSS, DT node for DisplayPort PHY and pinmux for
>> DP HPD. Add the clock frequency for serdes_refclk.
>>
>> Add the endpoint nodes to describe connection from:
>> DSS => MHDP => DisplayPort connector.
>>
>> Also add the GPIO expander-4 node and pinmux for main_i2c4 which is
>> required for controlling DP power. Set status for all required nodes
>> for DP-0 as "okay".
>>
>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>> [j-choudhary@ti.com: move all the changes together to enable DP-0 in EVM]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 119 +++++++++++++++++++++++
>>   1 file changed, 119 insertions(+)

[...]

>> +		reg = <0>;
>> +		cdns,num-lanes = <4>;
>> +		#phy-cells = <0>;
>> +		cdns,phy-type = <PHY_TYPE_DP>;
>> +		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
>> +			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
>> +	};
>> +};
>> +
>> +&mhdp {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&dp0_pins_default>;
>> +	phys = <&serdes4_dp_link>;
>> +	phy-names = "dpphy";
>> +};
>> +
>> +&dss_ports {
>> +	port {
> 
> Port index has not been added here. Since this port outputs to MHDP
> bridge, this should be "port@0", and a "reg = <0>;" property should be
> added below (along with the address and size cells properties).
> 
> I suppose this works functionally in this case, because the port gets
> defaulted to "0" by the driver. But in future, when we add support for
> other dss output(s) on j784s4-evm, the driver will need indices to
> distinguish among them.
> 

Okay. It makes sense.
Just one thing here. Adding reg here would require it to have #address-
cells and #size-cell but since we have only single child port that too
at reg=<0>, it would throw dtbs_check warning:

arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi:1828.20-1831.5: Warning
(graph_child_address): /bus@100000/dss@4a00000/ports: graph node has
single child node 'port@0', #address-cells/#size-cells are not necessary
   also defined at arch/arm64/boot/dts/ti/k3-j784s4-evm.dts:911.12-919.3


-jayesh

>> +		dpi0_out: endpoint {
>> +			remote-endpoint = <&dp0_in>;


[...]
