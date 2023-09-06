Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945CC7939A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjIFKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIFKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:16:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FD10C6;
        Wed,  6 Sep 2023 03:15:56 -0700 (PDT)
X-UUID: 5b01d9b24c9e11eea33bb35ae8d461a2-20230906
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=0ALVwmZJ1kapyejtzca1mMacgnD8PCnrO+/uBoh3Afc=;
        b=WcTuei81P3B7Fw1GFmQl1sMe4Soz1R46sqoHbzswwIcj3sHaU1kqFprMSW+M8jzbr0gmNNBwMjhAcuTffmRoOAcWYUy1e4mMvgV88WmC70un8kg5IPFZRGU7EAXx7EfAsTg4BBXpdSWGNNcAH6hLKC/wcGa0zEa9VDHkFlYJWqc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a48b2ff4-70c6-4fe6-8f8b-40649c20828b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:378b2f20-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5b01d9b24c9e11eea33bb35ae8d461a2-20230906
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 26976305; Wed, 06 Sep 2023 18:15:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Sep 2023 18:15:49 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 6 Sep 2023 18:15:49 +0800
Message-ID: <951e34bc-dda3-f9d4-b251-7f0fd02052ee@mediatek.com>
Date:   Wed, 6 Sep 2023 18:15:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add device-tree for Genio
 1200 EVK board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, Ben Lok <ben.lok@mediatek.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-2-macpaul.lin@mediatek.com>
 <2cb8069a-976b-0af4-a427-1e63ba4e7870@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <2cb8069a-976b-0af4-a427-1e63ba4e7870@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/23 17:34, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 06/09/2023 11:25, Macpaul Lin wrote:
>> +edp_panel_fixed_12v: regulator-1 {
>> +compatible = "regulator-fixed";
>> +regulator-name = "edp_backlight_12v";
>> +regulator-min-microvolt = <12000000>;
>> +regulator-max-microvolt = <12000000>;
>> +enable-active-high;
>> +gpio = <&pio 96 GPIO_ACTIVE_HIGH>;
>> +pinctrl-names = "default";
>> +pinctrl-0 = <&edp_panel_12v_en_pins>;
>> +};
>> +
>> +backlight_lcd0: backlight-lcd0 {
>> +compatible = "pwm-backlight";
>> +pwms = <&disp_pwm0 0 500000>;
>> +enable-gpios = <&pio 47 GPIO_ACTIVE_HIGH>;
>> +brightness-levels = <0 1023>;
>> +num-interpolated-steps = <1023>;
>> +default-brightness-level = <576>;
>> +};
>> +
>> +backlight_lcd1: backlight-lcd1 {
>> +compatible = "pwm-backlight";
>> +pwms = <&disp_pwm1 0 500000>;
>> +enable-gpios = <&pio 46 GPIO_ACTIVE_HIGH>;
>> +brightness-levels = <0 1023>;
>> +num-interpolated-steps = <1023>;
>> +default-brightness-level = <576>;
>> +};
>> +
>> +keys: gpio-keys {
>> +compatible = "gpio-keys";
>> +
>> +button-volume-up {
>> +wakeup-source;
>> +debounce-interval = <100>;
>> +gpios = <&pio 106 GPIO_ACTIVE_LOW>;
>> +label = "volume_up";
>> +linux,code = <KEY_VOLUMEUP>;
>> +};
>> +};
>> +
>> +can_clk: can-clk {
>> +compatible = "fixed-clock";
>> +#clock-cells = <0>;
>> +clock-frequency = <20000000>;
>> +clock-output-names = "can-clk";
>> +};
>> +
>> +wifi_3v3: wifi-3v3-regulator {
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.


This keeps a format with -regulator is because I've found some other use 
cases. It seems "-regulator" or "regulator-" could be arbitrary. I'm not 
sure if it is a new guideline for regulator's node. If there is in the 
devicetree document, maybe I just missed it?

However if this is for the purpose of keeping the DTS format tidy, I 
will update it in the next version, also fix another 
"usb-otg-vbus-regulator" node.

arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
a1d3281450ab2 (Christopher Obbard 2023-01-09 16:58:01 +0100  46) 
vcc5v0_sys: vcc5v0-sys-regulator {

arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
523adb553573d (Chris Morgan 2022-09-06 16:03:24 -0500 256) 
vcc_wifi: regulator-vcc-wifi {


> Thank you.
> 
> Best regards,
> Krzysztof


Thanks.
Macpaul Lin
> 
> 
