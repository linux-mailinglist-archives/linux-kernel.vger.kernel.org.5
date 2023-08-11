Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F59779638
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbjHKRft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjHKRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:35:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1B30FF;
        Fri, 11 Aug 2023 10:35:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BHZTdV038029;
        Fri, 11 Aug 2023 12:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691775329;
        bh=J8gCdb7j7JEFdE1hObpcr+I3xfxjndyGgJ/m6d25uyQ=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=wGgTRoa2wraMbNcP28cz2wAqgdxSFPUxXsy7faUKyZVp2zXKtXYukWSD9rIPyQOsz
         3aoDN7kNhgZ2e3nHEBLmjC8eWYELZZ0ly4PIJY5Pq3/Knu474BYmhQXXENK6jtuxd2
         Ngz1DC2MCqE1Poxg3s/jAl0ppCjRw9IXjqT9MBrE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BHZTPf128789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 12:35:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 12:35:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 12:35:29 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BHZPMC040910;
        Fri, 11 Aug 2023 12:35:26 -0500
Message-ID: <638d5883-5b95-403e-ecb9-8122d8774675@ti.com>
Date:   Fri, 11 Aug 2023 23:05:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am69-sk: Add phase tags marking
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
References: <20230811151644.3216621-1-a-nandan@ti.com>
 <20230811151644.3216621-4-a-nandan@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230811151644.3216621-4-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Apurva

On 8/11/2023 8:46 PM, Apurva Nandan wrote:
> bootph-all as phase tag was added to dt-schema
> (dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
> That's why add it also to Linux to be aligned with bootloader requirement.
>
> wkup_uart0, wkup_i2c0, mcu_uart0, main_uart8, main_sdhci0 and main_sdhci1
> are required for bootloader operation on TI K3 AM69-SK EVM. These IPs
> along with pinmuxes need to be marked for all bootloader phases, hence add
> bootph-all to these nodes in kernel dts.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
> [...]
>   &wkup_uart0 {
> +	bootph-all;
>   	/* Firmware usage */
>   	status = "reserved";
>   	pinctrl-names = "default";

I am not sure, if you want to treat wkup_uart in same way as you are 
treating secure_proxy_mcu in patch 1 of this series.

IMO, where we are making this node status is okay, mark booth-all at 
that place only.

Otherwise for rest of series

LGTM


> @@ -249,6 +257,7 @@ &wkup_uart0 {
>   };
>   
>   &wkup_i2c0 {
> +	bootph-all;
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wkup_i2c0_pins_default>;
> @@ -268,6 +277,7 @@ &wkup_gpio0 {
>   };
>   
>   &mcu_uart0 {
> +	bootph-all;
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_uart0_pins_default>;
> @@ -281,6 +291,7 @@ &mcu_i2c0 {
>   };
>   
>   &main_uart8 {
> +	bootph-all;
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_uart8_pins_default>;
> @@ -307,6 +318,7 @@ exp1: gpio@21 {
>   };
>   
>   &main_sdhci0 {
> +	bootph-all;
>   	/* eMMC */
>   	status = "okay";
>   	non-removable;
> @@ -315,6 +327,7 @@ &main_sdhci0 {
>   };
>   
>   &main_sdhci1 {
> +	bootph-all;
>   	/* SD card */
>   	status = "okay";
>   	pinctrl-0 = <&main_mmc1_pins_default>;
