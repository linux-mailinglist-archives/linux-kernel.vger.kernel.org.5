Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC980B173
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjLIB3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:29:20 -0500
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 17:29:25 PST
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com [103.129.254.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EE10F1;
        Fri,  8 Dec 2023 17:29:25 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=WZL9Qf7nBhlJXS+J4P/19lIGNWFFvmhrmiX0sT5kFHH7bXcfzghvQ3SXcaCix5VUwJFycuvS0ZBG6LtoaBpbYEkuDao9WOl7iVcEXJqM9+ntYAvLj2FIs0sB9qibSpqgWPVyD2JeRyhTcQwSr0KVK51ilKsckwZG9NSf9ndsvOw=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=HV2z/Dcq1u/NQro4ECOCLl8zo8h8Oih7gNKDIKTVpnI=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 3F245780176;
        Sat,  9 Dec 2023 09:28:56 +0800 (CST)
Message-ID: <d45b1a26-3ea3-4699-b86f-cc7d38718721@rock-chips.com>
Date:   Sat, 9 Dec 2023 09:28:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/17] arm64: dts: rockchip: Add vop on rk3588
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
References: <20231207075906.651771-1-andyshrk@163.com>
 <20231207080247.652780-1-andyshrk@163.com> <4730849.ejJDZkT8p0@diego>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <4730849.ejJDZkT8p0@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNMSVYaTkxDQk1CTUIZTkxVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8c4c311dfbb24fkuuu3f245780176
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohg6Hww5Qjw2Fk5LFh8iSxZW
        MhMaCy9VSlVKTEtJS0NOSEhMS0JOVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0JLSzcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko:

On 12/9/23 00:26, Heiko Stübner wrote:
> Hi Andy,
> 
> Am Donnerstag, 7. Dezember 2023, 09:02:47 CET schrieb Andy Yan:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> Add vop dt node for rk3588.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 96 +++++++++++++++++++++++
>>   1 file changed, 96 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> index 7064c0e9179f..a9810ca78dc4 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> @@ -593,6 +608,87 @@ i2c0: i2c@fd880000 {
>>   		status = "disabled";
>>   	};
>>   
>> +	vop: vop@fdd90000 {
>> +		compatible = "rockchip,rk3588-vop";
>> +		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
>> +		reg-names = "vop", "gamma_lut";
>> +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
>> +		clocks = <&cru ACLK_VOP>,
>> +			 <&cru HCLK_VOP>,
>> +			 <&cru DCLK_VOP0>,
>> +			 <&cru DCLK_VOP1>,
>> +			 <&cru DCLK_VOP2>,
>> +			 <&cru DCLK_VOP3>,
>> +			 <&cru PCLK_VOP_ROOT>;
>> +		clock-names = "aclk",
>> +			      "hclk",
>> +			      "dclk_vp0",
>> +			      "dclk_vp1",
>> +			      "dclk_vp2",
>> +			      "dclk_vp3",
>> +			      "pclk_vop";
>> +		resets = <&cru SRST_A_VOP>,
>> +			 <&cru SRST_H_VOP>,
>> +			 <&cru SRST_D_VOP0>,
>> +			 <&cru SRST_D_VOP1>,
>> +			 <&cru SRST_D_VOP2>,
>> +			 <&cru SRST_D_VOP3>;
>> +		reset-names = "axi",
>> +			      "ahb",
>> +			      "dclk_vp0",
>> +			      "dclk_vp1",
>> +			      "dclk_vp2",
>> +			      "dclk_vp3";
> 
> resets and reset-names do not seem to be part of the binding, so
> should probably be added there.

I will drop resets and reset-names in next version.
> 
> 
>> +		iommus = <&vop_mmu>;
>> +		power-domains = <&power RK3588_PD_VOP>;
>> +		rockchip,grf = <&sys_grf>;
>> +		rockchip,vop-grf = <&vop_grf>;
>> +		rockchip,vo1-grf = <&vo1_grf>;
>> +		rockchip,pmu = <&pmu>;
>> +
> 
> move this blank line _below_ the status=disabled please.

ok, will do.
> 
>> +		status = "disabled";
>> +		vop_out: ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			vp0: port@0 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				reg = <0>;
>> +			};
>> +
>> +			vp1: port@1 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				reg = <1>;
>> +			};
>> +
>> +			vp2: port@2 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				reg = <2>;
>> +			};
>> +
>> +			vp3: port@3 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				reg = <3>;
>> +			};
>> +		};
>> +	};
>> +
>> +	vop_mmu: iommu@fdd97e00 {
>> +		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
>> +		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
>> +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
>> +		interrupt-names = "vop_mmu";
> 
> interrupt-names is not part of the mainline iommu binding, so should be dropped

will do.
> 
> 
> Thanks
> Heiko
> 
> 
