Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8B79BB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347130AbjIKVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbjIKL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:59:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9ACDD;
        Mon, 11 Sep 2023 04:59:35 -0700 (PDT)
X-UUID: aac7828a509a11ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=vF/LHhiyaQ/Ygf2PDXc1yA4c6J4ikymDlpeMYyiX818=;
        b=jhzpwdbGVwa56QddTSOZt394XRSWup91RmSNs4a+ycB0F6UmmHXpmoZtsCjpGugktLuEst7dWESf82DpekCDUYcO8uXycluIVPyTFdDSRhkPf7sAdGoJMv6e5qj2xfWAcXuhOIw+lXi6U//0wjj1v/GuCuPBuv3jlNMj9YcluVU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:995c44e0-66b8-413b-bca7-71b58efd22a5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:add9cd13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aac7828a509a11ee8051498923ad61e6-20230911
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 430708145; Mon, 11 Sep 2023 19:59:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 19:59:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 11 Sep 2023 19:59:28 +0800
Message-ID: <faa59811-9d60-6b38-e721-be9a8e8d4749@mediatek.com>
Date:   Mon, 11 Sep 2023 19:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/2] arm64: dts: mediatek: add device-tree for Genio
 1200 EVK board
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, Ben Lok <ben.lok@mediatek.com>
References: <20230909132819.21626-1-macpaul.lin@mediatek.com>
 <20230909132819.21626-2-macpaul.lin@mediatek.com>
 <8b9e863b-35f6-7b86-d4b7-cb01ddad0958@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <8b9e863b-35f6-7b86-d4b7-cb01ddad0958@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.921800-8.000000
X-TMASE-MatchedRID: TmlY9+XBoTkNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cLBs8kDsMW7w0/3
        ZkXeY1OAsdosXJJWMVyclY59pSX0jBwWcp9rVIRcLTHwnYOikQ1aNaxZBRbNWtbgFKE16r97W+d
        0idLjpprfVWjDTn5L1xeDGeXH145fAoOXEsKbzlPghWDeMRWA/fryhnjDLC0KGDmnGwgDlxLGcp
        DUJnhRA0go1ASUm1da4o6Y3rd6BkgmNHlC7DQV5Zdc7I2df+mssuIso71Vk6LqqfQIVODNyAoek
        tpGiVj3l9als/KTifs525mZtA9daeu+ayo0SmHNR+GtoiXVeDGAfODDLypXmoZOiKw+neP1xUDT
        xL3vuSBLbMLc3nVqMrL0CwDGT5MlADAYgCjdKFt7sw7yO+Y9LBZO94uK1VSBe+xt+hmLFRO18YV
        tm8LwaHSstMHqiEQNbvsV/zcs6JyRzjH2MoyVHmNW0DAjL5p+2aYdnwn7qHeo+b+yOP0oGDnVEi
        ka+eVA14gnLq0QZ8e9TnZXLseR1r9ZdlL8eonaVnRXm1iHN1bEQdG7H66TyH4gKq42LRYkcbRYj
        efM4PAMRUim5rD2quXWgaXW3M4eZ9ztmG/8l/h+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.921800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 70055BEF4DC6783F0A4FFAEA13A869A6AD1FA33E169017906BC046589DC3461B2000:8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 17:09, AngeloGioacchino Del Regno wrote:
> Il 09/09/23 15:28, Macpaul Lin ha scritto:
>> Add basic device-tree for the Genio 1200-EVK board. This board
>> is made by MediaTek and has a MT8395 SoC (MT8195 family),
>> associated with the MT6359 and MT6360 PMICs, and
>> the MT7921 connectivity chip.
>>
>> The IOs available on that board are:
>> * 1 USB Type-C connector with DP aux mode support
>> * 2 USB Type-A connector with a USB hub
>> * 1 micro-USB port for gadget or OTG support
>> * 1 full size HDMI RX and 1 full size HDMI TX connector
>> * 1 micro SD slot
>> * 40 pins header
>> * SPI interface header
>> * 1 M.2 slot
>> * 1 audio jack
>> * 1 micro-USB port for serial debug
>> * 2 connectors for DSI displays, 1 of the DSI panel is installed
>> * 3 connectors for CSI cameras
>> * 1 connector for a eDP panel
>> * 1 MMC storage
>> * 1 Touch Panel (installed DSI display)
>> * 1 M.2 slot for 5G dongle
>>
>> This commit adds basic support in order to be able to boot.
>>
>> Signed-off-by: Ben Lok <ben.lok@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 901 ++++++++++++++++++
>>   2 files changed, 902 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>
>> Changes for v2:
>>   - correct SOC binding to "mediatek,mt8395".
>>   - Fix a Linux coding style comments for optee node.
>>   - Fix wifi fixed 3.3v power's node with "wifi-3v3-regulator".
>>   - Fix node name of mt6360 and mt6517 to generic dts name as "pmic".
>>   - Remove unecessary blank line.
>>   - Reording usb node as the order of "phy" then "host".
>>
>> Changes for v3:
>>   - Add back bindings for "mediatek,mt8195".
>>   - Fix wifi fixed 3.3v power's node with "regulator-2"
>>
>> Changes for v4:
>>   - Fix Makefile and dts file name with prefix "mt8395-".
>>   - Re-order all nodes in mt8395-genio-1200-evk.dts by alphabetical 
>> order.
>>   - Remove unused "DEBUG" node.
>>
>> Changes for v5:
>>   - Revise commit message for board's name.
>>   - swap the order of nodes 'mt6359_vcamio_ldo_reg' and
>>     'mt6359_vcn33_2_bt_ldo_reg' by alphabetical order.
>>   - Reorder some gpio pins by alphabetical order.
>>    - audio_default_pins, eth pins, and uart1 pins
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>> b/arch/arm64/boot/dts/mediatek/Makefile
>> index c99c3372a4b5..10e640c6ae08 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -53,4 +53,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += 
>> mt8195-cherry-tomato-r3.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> new file mode 100644
>> index 000000000000..5de2d102c577
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> @@ -0,0 +1,901 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2023 MediaTek Inc.
>> + * Author: Ben Lok <ben.lok@mediatek.com>
>> + *       Macpaul Lin <macpaul.lin@mediatek.com>
>> + */
>> +/dts-v1/;
>> +
>> +#include "mt8195.dtsi"
>> +#include "mt6359.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
>> +#include <dt-bindings/spmi/spmi.h>
>> +#include <dt-bindings/usb/pd.h>
>> +
>> +/ {
>> +    model = "MediaTek Genio 1200 EVK-P1V2-EMMC";
>> +    compatible = "mediatek,mt8395-evk", "mediatek,mt8395",
>> +             "mediatek,mt8195";
>> +
> 
> 
> ..snip..
> 
>> +&spi1 {
>> +    pinctrl-0 = <&spi1_pins>;
>> +    pinctrl-names = "default";
>> +    mediatek,pad-select = <0>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +    status = "okay";
>> +    cs-gpios = <&pio 64 GPIO_ACTIVE_LOW>;
>> +
>> +    can0: can@0 {
>> +        compatible = "microchip,mcp2518fd";
>> +        reg = <0>;
>> +        clocks = <&can_clk>;
>> +        spi-max-frequency = <20000000>;
>> +        interrupts-extended = <&pio 16 IRQ_TYPE_LEVEL_LOW>;
>> +        vdd-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
>> +        xceiver-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
>> +    };
>> +};
>> +
>> +&spi2 {
>> +    pinctrl-0 = <&spi2_pins>;
>> +    pinctrl-names = "default";
>> +    mediatek,pad-select = <0>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +    status = "okay";
>> +};
>> +
>> +&u3phy0 {
>> +    status = "okay";
>> +};
>> +
>> +&u3phy1 {
>> +    status = "okay";
>> +};
>> +
>> +&u3phy2 {
>> +    status = "okay";
>> +};
>> +
>> +&u3phy3 {
>> +    status = "okay";
>> +};
>> +
>> +&uart0 {
>> +    pinctrl-0 = <&uart0_pins>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>> +
>> +&uart1 {
>> +    pinctrl-0 = <&uart1_pins>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>> +
>> +&ufsphy {
>> +    status = "disabled";
>> +};
>> +
>> +&spmi {
> 
> spmi goes before u3phy0, after spi2.
> 
> after fixing:
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> 

Sorry, this part is missing in patch v5.
Now it is fixed in v6.
Thanks!

>> +    #address-cells = <2>;
>> +    #size-cells = <0>;
>> +
>> +    mt6315_6: pmic@6 {
>> +        compatible = "mediatek,mt6315-regulator";
>> +        reg = <0x6 SPMI_USID>;
>> +
>> +        regulators {
>> +            mt6315_6_vbuck1: vbuck1 {
>> +                regulator-compatible = "vbuck1";
>> +                regulator-name = "Vbcpu";
>> +                regulator-min-microvolt = <300000>;
>> +                regulator-max-microvolt = <1193750>;
>> +                regulator-enable-ramp-delay = <256>;
>> +                regulator-allowed-modes = <0 1 2>;
>> +                regulator-always-on;
>> +            };
>> +        };
>> +    };
>> +
>> +    mt6315_7: pmic@7 {
>> +        compatible = "mediatek,mt6315-regulator";
>> +        reg = <0x7 SPMI_USID>;
>> +
>> +        regulators {
>> +            mt6315_7_vbuck1: vbuck1 {
>> +                regulator-compatible = "vbuck1";
>> +                regulator-name = "Vgpu";
>> +                regulator-min-microvolt = <300000>;
>> +                regulator-max-microvolt = <1193750>;
>> +                regulator-enable-ramp-delay = <256>;
>> +                regulator-allowed-modes = <0 1 2>;
>> +            };
>> +        };
>> +    };
>> +};
>> +
>> +&xhci0 {
>> +    status = "okay";
>> +};
>> +
>> +&xhci1 {
>> +    vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> +    status = "okay";
>> +};
>> +
>> +&xhci2 {
>> +    vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> +    status = "okay";
>> +};
>> +
>> +&xhci3 {
>> +    vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> +    status = "okay";
>> +};
> 
>

Best Regards,
Macpaul Lin
