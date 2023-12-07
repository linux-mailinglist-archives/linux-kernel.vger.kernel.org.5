Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440168088B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjLGM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjLGM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:59:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724810C9;
        Thu,  7 Dec 2023 05:00:01 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 49FD26607393;
        Thu,  7 Dec 2023 12:59:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701954000;
        bh=Y+2lb/adxRpwvJt48trS4KHvgRlrTAEuUje7p3jBFO0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CWCpYUiXIpeqxsPyl1Deideracu37T1KiROxaMuMp/0hDwQr68un3/L+uX5YRRP8z
         Wuch0HXWF7+YvSMY2HdgJMlnJG+2dW4iO9mxf20fzIgGR+pFYKeDwEFeWd79OPFGwl
         QQumqSDxtafj09uEXyjt3ca85nL8rwwGFIn/1BqEL2+L0FBK305ExXKFs9wAgAswr4
         rjt+iD/bNLKkML8xRbXnbyqZK+6HNaBJGosUV5k70sEJ2B4CO4t3JnKXlTD6UXz0Wf
         Zs10hKX5GvO1C/r2DV/cMC+fAxAiOkn1OJQFYrmX+6sYR+5OEXa8QSY9oghg78OjM/
         dkEOVOMkC/Wbg==
Message-ID: <aaa55b65-0221-48a0-b78a-ff84f210d16b@collabora.com>
Date:   Thu, 7 Dec 2023 13:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231204084012.2281292-1-wenst@chromium.org>
 <20231204084012.2281292-7-wenst@chromium.org>
 <ab7988af-e7f9-433d-b35e-138f79ce82c0@collabora.com>
 <CAGXv+5EyHXWgbvtxx-skzi6FNEnZD8QEHQ2Wq224anY+QKUrew@mail.gmail.com>
 <CAGXv+5H9dkYOUEDEYtDOzH9ma3wxuGMLfWy+9pE2swTFdNxOnQ@mail.gmail.com>
 <CAGXv+5FhTwovv7qztGfC+FG8pb-kzZomRPgKboFYJmBTZ=mj6g@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FhTwovv7qztGfC+FG8pb-kzZomRPgKboFYJmBTZ=mj6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/12/23 12:28, Chen-Yu Tsai ha scritto:
> On Thu, Dec 7, 2023 at 8:23 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Thu, Dec 7, 2023 at 2:28 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>>
>>> On Mon, Dec 4, 2023 at 11:27 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 04/12/23 09:40, Chen-Yu Tsai ha scritto:
>>>>> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
>>>>> Krabby design.
>>>>>
>>>>> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
>>>>> convertible device with touchscreen and stylus.
>>>>>
>>>>> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
>>>>> device. It does not have a touchscreen or stylus.
>>>>>
>>>>> The two devices both have two variants. The difference is a second
>>>>> source touchpad controller that shares the same address as the original,
>>>>> but is incompatible.
>>>>>
>>>>> The extra SKU IDs for the Tentacruel devices map to different sensor
>>>>> components attached to the Embedded Controller. These are not visible
>>>>> to the main processor.
>>>>>
>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> ---
>>>>> Changes since v2:
>>>>> - Picked up Conor's ack
>>>>> - Rename touchpad to trackpad
>>>>> - Drop pinctrl properties from trackpad in tentacruel/tentacool second
>>>>>     source trackpad
>>>>>
>>>>> Changes since v1:
>>>>> - Reorder SKU numbers in descending order.
>>>>> - Fixed pinconfig node names
>>>>> - Moved pinctrl-* properties after interrupts-*
>>>>> - Switched to interrupts-extended for external components
>>>>> - Marked ADSP as explicitly disabled, with a comment explaining that it
>>>>>     stalls the system
>>>>> - Renamed "touchpad" to "trackpad"
>>>>> - Dropped bogus "no-laneswap" property from it6505 node
>>>>> - Moved "realtek,jd-src" property to after all the regulator supplies
>>>>> - Switched to macros for MT6366 regulator "regulator-allowed-modes"
>>>>> - Renamed "vgpu" regulator name to allow coupling, with a comment
>>>>>     containing the name used in the design
>>>>> - Renamed "cr50" node name to "tpm"
>>>>> - Moved trackpad_pins reference up to i2c2; workaround for second source
>>>>>     component resource sharing.
>>>>> - Fix copyright year
>>>>> - Fixed touchscreen supply name
>>>>>
>>>>>    arch/arm64/boot/dts/mediatek/Makefile         |    4 +
>>>>>    .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
>>>>>    .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
>>>>>    .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
>>>>>    .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
>>>>>    .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
>>>>>    .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1719 +++++++++++++++++
>>>>>    7 files changed, 2003 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>>>> index e6e7592a3645..442af61b1305 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>>>> @@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>>>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>>>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
>>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
>>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
>>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262148.dtb
>>>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>>>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>>>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..9b2b64525961
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
>>>>> @@ -0,0 +1,129 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright 2022 Google LLC
>>>>> + */
>>>>> +
>>>>> +/dts-v1/;
>>>>> +#include "mt8186-corsola.dtsi"
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +
>>>>> +/ {
>>>>> +     aliases {
>>>>> +             i2c4 = &i2c4;
>>>>> +     };
>>>>> +};
>>>>> +
>>>>> +&dsi_out {
>>>>> +     remote-endpoint = <&ps8640_in>;
>>>>> +};
>>>>> +
>>>>> +&i2c0 {
>>>>> +     clock-frequency = <400000>;
>>>>> +
>>>>> +     ps8640: edp-bridge@8 {
>>>>> +             compatible = "parade,ps8640";
>>>>> +             reg = <0x8>;
>>>>> +             powerdown-gpios = <&pio 96 GPIO_ACTIVE_LOW>;
>>>>> +             reset-gpios = <&pio 98 GPIO_ACTIVE_LOW>;
>>>>> +             pinctrl-names = "default";
>>>>> +             pinctrl-0 = <&ps8640_pins>;
>>>>> +             vdd12-supply = <&mt6366_vrf12_reg>;
>>>>> +             vdd33-supply = <&mt6366_vcn33_reg>;
>>>>> +
>>>>> +             ports {
>>>>> +                     #address-cells = <1>;
>>>>> +                     #size-cells = <0>;
>>>>> +
>>>>> +                     port@0 {
>>>>> +                             reg = <0>;
>>>>> +
>>>>> +                             ps8640_in: endpoint {
>>>>> +                                     remote-endpoint = <&dsi_out>;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     port@1 {
>>>>> +                             reg = <1>;
>>>>> +
>>>>> +                             ps8640_out: endpoint {
>>>>> +                                     remote-endpoint = <&panel_in>;
>>>>> +                             };
>>>>> +                     };
>>>>> +             };
>>>>> +
>>>>> +             aux-bus {
>>>>> +                     panel {
>>>>> +                             compatible = "edp-panel";
>>>>> +                             power-supply = <&pp3300_disp_x>;
>>>>> +                             backlight = <&backlight_lcd0>;
>>>>> +
>>>>> +                             port {
>>>>> +                                     panel_in: endpoint {
>>>>> +                                             remote-endpoint = <&ps8640_out>;
>>>>> +                                     };
>>>>> +                             };
>>>>> +                     };
>>>>> +             };
>>>>> +     };
>>>>> +};
>>>>> +
>>>>> +&i2c1 {
>>>>> +     i2c-scl-internal-delay-ns = <10000>;
>>>>> +
>>>>> +     touchscreen: touchscreen@10 {
>>>>> +             compatible = "hid-over-i2c";
>>>>> +             reg = <0x10>;
>>>>> +             interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
>>>>> +             pinctrl-names = "default";
>>>>> +             pinctrl-0 = <&touchscreen_pins>;
>>>>> +             post-power-on-delay-ms = <10>;
>>>>> +             hid-descr-addr = <0x0001>;
>>>>> +             vdd-supply = <&pp3300_s3>;
>>>>> +     };
>>>>> +};
>>>>> +
>>>>> +&i2c4 {
>>>>> +     pinctrl-names = "default";
>>>>> +     pinctrl-0 = <&i2c4_pins>;
>>>>> +     clock-frequency = <400000>;
>>>>> +     status = "okay";
>>>>> +
>>>>> +     proximity@28 {
>>>>> +             compatible = "semtech,sx9324";
>>>>> +             reg = <0x28>;
>>>>> +             interrupts-extended = <&pio 5 IRQ_TYPE_LEVEL_LOW>;
>>>>> +             pinctrl-names = "default";
>>>>> +             pinctrl-0 = <&sar_sensor_pins>;
>>>>> +             vdd-supply = <&mt6366_vio18_reg>;
>>>>> +             svdd-supply = <&mt6366_vio18_reg>;
>>>>> +             #io-channel-cells = <1>;
>>>>
>>>>   From the newest DTS coding style document:
>>>>
>>>> The following order of properties in device nodes is preferred:
>>>>
>>>> 1. compatible
>>>> 2. reg
>>>> 3. ranges
>>>> 4. Standard/common properties (defined by common bindings, e.g. without
>>>>      vendor-prefixes)
>>>> 5. Vendor-specific properties
>>>> 6. status (if applicable)
>>>> 7. Child nodes, where each node is preceded with a blank line
>>>>
>>>> The "status" property is by default "okay", thus it can be omitted.
>>>>
>>>> The above-described ordering follows this approach:
>>>>
>>>> 1. Most important properties start the node: compatible then bus addressing to
>>>>      match unit address.
>>>> 2. Each node will have common properties in similar place.
>>>> 3. Status is the last information to annotate that device node is or is not
>>>>      finished (board resources are needed).
>>>
>>> Wishing for a checking tool now. :p
>>>
>>>> #io-channel-cells goes after `reg` (same for the other instances) :-)
>>>
>>> Ack (though it looks weird).
>>>
>>>>> +     };
>>>>> +};
>>>>> +
>>>>> +&pio {
>>>>> +     i2c4_pins: i2c4-pins {
>>>>> +             pins-bus {
>>>>> +                     pinmux = <PINMUX_GPIO136__FUNC_SDA4>,
>>>>> +                              <PINMUX_GPIO135__FUNC_SCL4>;
>>>>> +                     bias-disable;
>>>>> +                     drive-strength = <4>;
>>>>> +                     input-enable;
>>>>> +             };
>>>>> +     };
>>>>> +
>>>>> +     ps8640_pins: ps8640-pins {
>>>>> +             pins-pwrdn-rst {
>>>>> +                     pinmux = <PINMUX_GPIO96__FUNC_GPIO96>,
>>>>> +                              <PINMUX_GPIO98__FUNC_GPIO98>;
>>>>> +                     output-low;
>>>>> +             };
>>>>> +     };
>>>>> +
>>>>> +     sar_sensor_pins: sar-sensor-pins {
>>>>> +             pins-irq {
>>>>> +                     pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
>>>>> +                     input-enable;
>>>>> +                     bias-pull-up;
>>>>> +             };
>>>>> +     };
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
>>>>> new file mode 100644
>>>>> index 000000000000..9bb64353ca65
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
>>>>> @@ -0,0 +1,57 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright 2022 Google LLC
>>>>> + */
>>>>> +
>>>>> +/dts-v1/;
>>>>> +#include "mt8186-corsola-krabby.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     model = "Google Tentacool board";
>>>>> +     compatible = "google,tentacruel-sku327681", "google,tentacruel", "mediatek,mt8186";
>>>>> +     chassis-type = "laptop";
>>>>> +};
>>>>> +
>>>>> +/* Tentacool omits the pen. */
>>>>> +&gpio_keys {
>>>>> +     status = "disabled";
>>>>> +};
>>>>> +
>>>>> +/* Tentacool omits the touchscreen; nothing else is on i2c1. */
>>>>> +&i2c1 {
>>>>> +     status = "disabled";
>>>>> +};
>>>>> +
>>>>> +&keyboard_controller {
>>>>> +     function-row-physmap = <
>>>>> +             MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
>>>>> +             MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
>>>>> +             MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
>>>>> +             MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
>>>>> +             MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
>>>>> +             MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
>>>>> +             MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
>>>>> +             MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
>>>>> +             MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
>>>>> +             MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
>>>>> +     >;
>>>>> +
>>>>> +     linux,keymap = <
>>>>> +             MATRIX_KEY(0x00, 0x02, KEY_BACK)
>>>>> +             MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
>>>>> +             MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
>>>>> +             MATRIX_KEY(0x01, 0x02, KEY_SCALE)
>>>>> +             MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
>>>>> +             MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
>>>>> +             MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
>>>>> +             MATRIX_KEY(0x02, 0x09, KEY_MUTE)
>>>>> +             MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
>>>>> +             MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
>>>>> +             CROS_STD_MAIN_KEYMAP
>>>>> +     >;
>>>>> +};
>>>>> +
>>>>> +/* Tentacool omits the touchscreen. */
>>>>> +&touchscreen {
>>>>> +     status = "disabled";
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
>>>>> new file mode 100644
>>>>> index 000000000000..c3ae6f9616c8
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
>>>>> @@ -0,0 +1,24 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright 2023 Google LLC
>>>>> + */
>>>>> +
>>>>> +#include "mt8186-corsola-tentacool-sku327681.dts"
>>>>> +
>>>>> +/ {
>>>>> +     compatible = "google,tentacruel-sku327683", "google,tentacruel", "mediatek,mt8186";
>>>>> +};
>>>>> +
>>>>> +/* This variant replaces only the trackpad controller. */
>>>>> +&i2c2 {
>>>>> +     /delete-node/ trackpad@15;
>>>>
>>>> Why are you deleting the trackpad@15 node?
>>>>
>>>> You can simply override the compatible, or actually omit the compatible string
>>>> in the *.dtsi file, and set just that in each board *.dts.
>>>>
>>>> dtsi:
>>>>          trackpad_a: trackpad@15 {
>>>>                  /* Compatible is set in each board dts */
>>>>                  reg, interrupts, others
>>>>          }
>>>>
>>>> dts:
>>>>
>>>> &trackpad_a {
>>>>          compatible = "elan,ekth3000";
>>>> };
>>>
>>> The original trackpad@15 comes from the base design and is used for all
>>> models other than the ones with the conflicting component. Hence I believe
>>> it should live in the base .dtsi.
>>>
>>> The delete-node makes it much less likely to have any lingering properties.
>>> These are not nodes that just differ in compatible strings like DSI panels.
>>> They have incompatible bindings. For example, elan,ekth3000 uses "vcc-supply",
>>> while "hid-over-i2c" uses "vdd-supply".
>>>
>>> And going back to my previous argument, the base design used one specific
>>> model which is carried over to all the other models.
>>>
>>> Suppose I add a phandle to the original trackpad, and do
>>>
>>>      /delete-node/ &trackpad;
>>>
>>> Would that be better?
>>>
>>>> other dts:
>>>>
>>>> &trackpad_a {
>>>>          compatible = "hid-over-i2c";
>>>> };
>>>>
>>>>> +
>>>>> +     trackpad@15 {
>>>>> +             compatible = "hid-over-i2c";
>>>>> +             reg = <0x15>;
>>>>> +             interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>>>>> +             hid-descr-addr = <0x0001>;
>>>>> +             vdd-supply = <&pp3300_s3>;
>>>>> +             wakeup-source;
>>>>> +     };
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
>>>>> new file mode 100644
>>>>> index 000000000000..26d3451a5e47
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
>>>>> @@ -0,0 +1,44 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright 2022 Google LLC
>>>>> + */
>>>>> +
>>>>> +/dts-v1/;
>>>>> +#include "mt8186-corsola-krabby.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     model = "Google Tentacruel board";
>>>>> +     compatible = "google,tentacruel-sku262147", "google,tentacruel-sku262146",
>>>>> +                  "google,tentacruel-sku262145", "google,tentacruel-sku262144",
>>>>> +                  "google,tentacruel", "mediatek,mt8186";
>>>>> +     chassis-type = "convertible";
>>>>> +};
>>>>> +
>>>>> +&keyboard_controller {
>>>>> +     function-row-physmap = <
>>>>> +             MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
>>>>> +             MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
>>>>> +             MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
>>>>> +             MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
>>>>> +             MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
>>>>> +             MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
>>>>> +             MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
>>>>> +             MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
>>>>> +             MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
>>>>> +             MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
>>>>> +     >;
>>>>> +
>>>>> +     linux,keymap = <
>>>>> +             MATRIX_KEY(0x00, 0x02, KEY_BACK)
>>>>> +             MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
>>>>> +             MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
>>>>> +             MATRIX_KEY(0x01, 0x02, KEY_SCALE)
>>>>> +             MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
>>>>> +             MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
>>>>> +             MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
>>>>> +             MATRIX_KEY(0x02, 0x09, KEY_MUTE)
>>>>> +             MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
>>>>> +             MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
>>>>> +             CROS_STD_MAIN_KEYMAP
>>>>> +     >;
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>>>> new file mode 100644
>>>>> index 000000000000..447b57b12b41
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>>>> @@ -0,0 +1,26 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright 2023 Google LLC
>>>>> + */
>>>>> +
>>>>> +#include "mt8186-corsola-tentacruel-sku262144.dts"
>>>>> +
>>>>> +/ {
>>>>> +     compatible = "google,tentacruel-sku262151", "google,tentacruel-sku262150",
>>>>> +                  "google,tentacruel-sku262149", "google,tentacruel-sku262148",
>>>>> +                  "google,tentacruel", "mediatek,mt8186";
>>>>> +};
>>>>> +
>>>>> +/* This variant replaces only the trackpad controller. */
>>>>> +&i2c2 {
>>>>> +     /delete-node/ trackpad@15;
>>>>> +
>>>>> +     trackpad@15 {
>>>>> +             compatible = "hid-over-i2c";
>>>>> +             reg = <0x15>;
>>>>> +             interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>>>>> +             hid-descr-addr = <0x0001>;
>>>>> +             vdd-supply = <&pp3300_s3>;
>>>>> +             wakeup-source;
>>>>> +     };
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..8726b2916ef1
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>>> @@ -0,0 +1,1719 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright (C) 2022 MediaTek Inc.
>>>>> + */
>>>>> +/dts-v1/;
>>>>> +#include "mt8186.dtsi"
>>>>> +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/input/input.h>
>>>>> +#include <dt-bindings/input/gpio-keys.h>
>>>>> +#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
>>>>> +
>>>>> +/ {
>>>>> +     aliases {
>>>>> +             i2c0 = &i2c0;
>>>>> +             i2c1 = &i2c1;
>>>>> +             i2c2 = &i2c2;
>>>>> +             i2c3 = &i2c3;
>>>>> +             i2c5 = &i2c5;
>>>>> +             mmc0 = &mmc0;
>>>>> +             mmc1 = &mmc1;
>>>>> +             serial0 = &uart0;
>>>>> +     };
>>>>> +
>>>>> +     chosen {
>>>>> +             stdout-path = "serial0:115200n8";
>>>>> +     };
>>>>> +
>>>>> +     memory@40000000 {
>>>>> +             device_type = "memory";
>>>>> +             /* The size should be filled in by the bootloader. */
>>>>> +             reg = <0 0x40000000 0 0>;
>>>>> +     };
>>>>> +
>>>>> +     backlight_lcd0: backlight-lcd0 {
>>>>> +             compatible = "pwm-backlight";
>>>>> +             pwms = <&pwm0 0 500000>;
>>>>> +             power-supply = <&ppvar_sys>;
>>>>> +             enable-gpios = <&pio 152 0>;
>>>>> +             brightness-levels = <0 1023>;
>>>>> +             num-interpolated-steps = <1023>;
>>>>> +             default-brightness-level = <576>;
>>>>> +     };
>>>>> +
>>>>> +     btsco: bt-sco {
>>>>
>>>> Do you really need the phandle to bt-sco?
>>>
>>> No. But the sound node probably should be referencing it and the dmic
>>> node via DT instead of hardcoding the DAI and codec names in the machine
>>> driver.
>>>
>>> Anyway, will remove the label for now.
>>>
>>>> Also, this node describes a codec, so: "bt-sco-codec" please!
>>>
>>> Ack.
>>>
>>>>> +             compatible = "linux,bt-sco";
>>>>> +             #sound-dai-cells = <0>;
>>>>> +     };
>>>>> +
>>>>> +     dmic_codec: dmic-codec {
>>>>
>>>> This phandle is unused...
>>>
>>> Removed.
>>>
>>>> ..snip..
>>>>
>>>>> +
>>>>> +&adsp {
>>>>> +     memory-region = <&adsp_dma_mem>, <&adsp_mem>;
>>>>> +     status = "disabled"; /* causes stall */
>>>>
>>>> This is a firmware issue: once the correct firmware is uploaded to linux-firmware
>>>> the dsp node can get enabled... so it we make sure that this happens before this
>>>> devicetree gets picked, we can avoid a second commit enabling audio.
>>>>
>>>> After all, since we *want to* use the Xtensa DSP for audio, without it booted
>>>> sound won't work *anyway*.... so having the firmware in place can also be seen
>>>> as a direct dependency of the entire audio functionality.
>>>>
>>>> P.S.: The FW that is distributed with ChromeOS works just fine!
>>>
>>> I'll give that a try.
>>
>> I have:
>>
>> sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-5494c
>> sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
>> sof-audio-of-mt8186 10680000.adsp: unknown sof_ext_man header type 3 size 0x30
>> sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-5494c
>>
>> and it's still hanging.
> 
> Looks like I was still using the bad version due to module options...
> 
> After removing the options, I now have:
> 
> sof-audio-of-mt8186 10680000.adsp: DT DSP detected
> sof-audio-of-mt8186 10680000.adsp: assigned reserved memory node memory@61000000
> sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-714c6
> sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> sof-audio-of-mt8186 10680000.adsp: unknown sof_ext_man header type 3 size 0x30
> sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-714c6
> sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> 
> But sound is still deferring probe:
> 
> # cat /sys/kernel/debug/devices_deferred
> sound    mt8186_mt6366_rt1019_rt5682s:
> mt8186_mt6366_rt1019_rt5682s_dev_probe snd_soc_register_card fail
> 

Yes, this happens because of the missing IT6505 HDMI audio support - but it's not
giving any side effect anyway... in this case, as far as DT is concerned... there
will be no change, and no side effects on working parts of the system, so we can
(imo) upstream this even if the driver-code-only dependency is not there yet.

Cheers!
Angelo

> ChenYu
> 
>> And FTR, I think sound is also blocked on the it6505 audio support series.
>>
>> ChenYu
>>
>>
>>
>>>>> +};
>>>>> +
>>>>> +&afe {
>>>>> +     i2s0-share = "I2S1";
>>>>> +     i2s3-share = "I2S2";
>>>>> +     status = "okay";
>>>>> +};
>>>>> +
>>>>
>>>> ..snip..
>>>>
>>>>> +&i2c2 {
>>>>> +     pinctrl-names = "default";
>>>>> +     /*
>>>>> +      * Trackpad pin put here to work around second source components
>>>>> +      * sharing the pinmux in steelix designs.
>>>>> +      */
>>>>> +     pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
>>>>
>>>> There's no choice for now... even if this is not beautiful to see... but it's still
>>>> ok for me because we can revisit this later when the HW Prober mechanism will be
>>>> upstreamed.
>>>
>>> Yup. Working on that.
>>>
>>>>> +     clock-frequency = <400000>;
>>>>> +     i2c-scl-internal-delay-ns = <10000>;
>>>>> +     status = "okay";
>>>>> +
>>>>> +     trackpad@15 {
>>>>> +             compatible = "elan,ekth3000";
>>>>> +             reg = <0x15>;
>>>>> +             interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>>>>> +             vcc-supply = <&pp3300_s3>;
>>>>> +             wakeup-source;
>>>>> +     };
>>>>> +};
>>>>> +
>>>>
>>>> Thanks,
>>>> Angelo
>>>
>>> Thanks for the review again.
>>>
>>> ChenYu

