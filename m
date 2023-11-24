Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44E7F70B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjKXKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:02:10 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49131B6;
        Fri, 24 Nov 2023 02:02:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C26D621CA;
        Fri, 24 Nov 2023 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1700820132; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
        bh=H98COdnbfmR0Z7+Y4wrDzDOT7wGeif7oLU80xotr7Cg=;
        b=G8qXOg2ZwxS0VqU2OLG5A9GeE0U5E874KNp6+MorX63r6nMF92WQBNmBJERLVKhudHCDin
        Ce9MM7UxIuwJrWR/4TC0aG0MUHJOvW7zenHqaWStbyTPPWHKS9r8QXzqZwWVoDxAEZ1RxQ
        DEghevRtfIrHPU0SZv0qMba1n6rLbdBbc0wTnW5ab0Rkb03znTKgxD5h8vwp4Cls2lLrcD
        tPQVY2p6tQFIKHYtp8uhdJ23zwcC1o2KbxQYZQGZdx+9qsKLm9JSA6FRxiuPI6IVHWL4vK
        92tln74wmCPojy+UIimfYfyspZjszAtu4OlksbnrnHyGzrAtj9of6SbXOxCsmQ==
Message-ID: <798aeac1-bca9-4512-a11c-d7145aeb5645@lexina.in>
Date:   Fri, 24 Nov 2023 13:02:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: amlogic: minor whitespace cleanup around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231124094700.58071-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US, ru-RU
From:   Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20231124094700.58071-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

24/11/2023 12.47, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts    | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi        | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi            | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> index 0062667c4f65..c9e84db0831a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> @@ -30,7 +30,7 @@ &sd_emmc_b {
>   &uart_B {
>   	bluetooth {
>   		compatible = "realtek,rtl8822cs-bt";
> -		enable-gpios  = <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
>   		host-wake-gpios = <&gpio GPIOZ_8 GPIO_ACTIVE_HIGH>;
>   		device-wake-gpios = <&gpio GPIOZ_6 GPIO_ACTIVE_HIGH>;
>   	};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> index 995ce10d5c81..08c33ec7e9f1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> @@ -369,7 +369,7 @@ &uart_A {
>   
>   	bluetooth {
>   		compatible = "realtek,rtl8822cs-bt";
> -		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>   		host-wake-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
>   		device-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
>   	};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> index 0a6a12808568..4b8db872bbf3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> @@ -487,7 +487,7 @@ &uart_A {
>   
>   	bluetooth {
>   		compatible = "realtek,rtl8822cs-bt";
> -		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>   		host-wake-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
>   		device-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
>   	};


Reviewed-by: Viacheslav Bocharov<adeep@lexina.in>

