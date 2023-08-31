Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5D778E544
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjHaEGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjHaEGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:06:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992CFA1;
        Wed, 30 Aug 2023 21:06:32 -0700 (PDT)
X-UUID: c13e8eae47b311ee9cb5633481061a41-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Hac1eOr0HMqvjUkNqmT/hwInrwdrbDUqtSKUfCEWDkk=;
        b=K8/+j9y0HlkqJLI+dKBUy77VXuKbbAAeqYleE1aDlfpqFgcVFOx9duBZS/Lhn7PCamCOPM7YSc1GMPweIf6V1gezfqhhYi7cYb52ugwszdqbv5vPWlN06bsIBregxFW8Q6h8Yy+SFrHNBiDB3CLfLgzZr1+SsQqmetTy41wypZo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fc58b336-9926-46f5-8033-7a266f63a0aa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:2469f21f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c13e8eae47b311ee9cb5633481061a41-20230831
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 765949934; Thu, 31 Aug 2023 12:06:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 12:06:25 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 31 Aug 2023 12:06:24 +0800
Message-ID: <3fb9999c-9bdb-d81a-73cc-3f15749521c8@mediatek.com>
Date:   Thu, 31 Aug 2023 12:06:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8195-demo: simplify mt6360
 nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Fabien Parent" <fparent@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230830111532.9048-1-macpaul.lin@mediatek.com>
 <20230830111532.9048-4-macpaul.lin@mediatek.com>
 <657fcef0-8e15-0bdd-b91c-9a172e2ad391@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <657fcef0-8e15-0bdd-b91c-9a172e2ad391@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 19:30, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 30/08/2023 13:15, Macpaul Lin wrote:
>> The dts file for the MediaTek MT8195 demo board has been refactored
>> to improve the configuration of the MT6360 multi-function PMIC.
>> 
>> The changes include:
>>  - Addition of the mt6360.dtsi include file, which contains the common
>>    configuration of the MT6360 for all mt8195 boards.
>>  - Removal of the direct inclusion of the mt6360-regulator.h file.
>>  - Removal of the common configuration of the MT6360 PMIC since
>>    the included mt6360.dtsi is used.
>>  - Add names according to the schematic of mt8195-demo board for
>>    mt6360 nodes.
>> 
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 173 ++++++++-----------
>>  1 file changed, 74 insertions(+), 99 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> index 8aea6f5d72b3..d082d679dbbe 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> @@ -11,7 +11,6 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>> -#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
>>  
>>  / {
>>  model = "MediaTek MT8195 demo board";
>> @@ -130,103 +129,9 @@
>>  mt6360: pmic@34 {
>>  compatible = "mediatek,mt6360";
>>  reg = <0x34>;
>> -interrupt-controller;
>> +pinctrl-0 = <&mt6360_pins>;
>> +pinctrl-names = "default";
>>  interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
>> -interrupt-names = "IRQB";
>> -
>> -charger {
>> -compatible = "mediatek,mt6360-chg";
>> -richtek,vinovp-microvolt = <14500000>;
>> -
>> -otg_vbus_regulator: usb-otg-vbus-regulator {
>> -regulator-compatible = "usb-otg-vbus";
>> -regulator-name = "usb-otg-vbus";
>> -regulator-min-microvolt = <4425000>;
>> -regulator-max-microvolt = <5825000>;
>> -};
>> -};
>> -
>> -regulator {
>> -compatible = "mediatek,mt6360-regulator";
>> -LDO_VIN3-supply = <&mt6360_buck2>;
>> -
>> -mt6360_buck1: buck1 {
> 
> Your patchset does not look bisectable. Does not look tested, either...
> Why having duplicated regulators (?) and then removing correct
> regulators and keeping wrong ones?
> 
>> -regulator-compatible = "BUCK1";
>> -regulator-name = "mt6360,buck1";
>> -regulator-min-microvolt = <300000>;
>> -regulator-max-microvolt = <1300000>;
>> -regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> -   MT6360_OPMODE_LP
>> -   MT6360_OPMODE_ULP>;
>> -regulator-always-on;
>> -};
> 
> ...
> 
>>  };
>>  };
>>  
>> @@ -259,8 +164,8 @@
>>  cap-sd-highspeed;
>>  sd-uhs-sdr50;
>>  sd-uhs-sdr104;
>> -vmmc-supply = <&mt6360_ldo5>;
>> -vqmmc-supply = <&mt6360_ldo3>;
>> +vmmc-supply = <&mt6360_vmch_pmu_ldo5_reg>;
>> +vqmmc-supply = <&mt6360_vmc_pmu_ldo3_reg>;
>>  status = "okay";
>>  };
>>  
>> @@ -300,6 +205,67 @@
>>  regulator-always-on;
>>  };
>>  
>> +#include "mt6360.dtsi"
> 
> Includes are in the top part of the DTS. Sometimes bottom, but never in
> the middle.
> 
> 
> Best regards,
> Krzysztof
> 

MT6360 is an external component controlled by I2C.
On some mt8195 boards, it is connected to I2C6.
But on some smart phone boards, they are connected to I2C5.
I agree to put the includes in the top or in the bottom,
but it to include I2C node together in mt6360.dtsi will be necessary
to avoid build error. It might introduce mt6360-i2c5.dtsi
or mt6360-i2c6.dtsi in the future.

I think the better approach is to expand the common nodes in the board's 
dts, rather than organizing them into dtsi.

Please drop these 2 patches for adding mt6360.dtsi and modification for 
mt8195-demo.dts (patch 3/4 and 4/4) for the patch set.

Thanks for the review. :)
Macpaul Lin

