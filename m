Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33C761211
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjGYK7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjGYK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:58:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529F211B;
        Tue, 25 Jul 2023 03:55:34 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PA3XNW017003;
        Tue, 25 Jul 2023 12:55:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=84skJsHFBbLfJSMlPNHQ+kQWJqyQB1R4sOuBvFYxBvo=;
 b=3a4+EUWkn6pQShKO2au+wN2f/gRwLzdSQ7FFu6o58dphPQEJePsW/c4a9gTnob02iylW
 eU+Avt0XO10YPO6Q2/XLToKcYe49BQOeoxnnnrC7pz5nVwUtE1L9uLq1S+Rz+nIWpJbE
 1aIvksZU5aFK0NB9+OqFYPpfpxtCtRYUA1H/oIg8e45ZToBwna6GCVkcFkxnrINDbtjj
 jcVDuv/07aLqTwCcve2GLHRePG3AJWhIbgyaiznDytxDxvj1p0nPO8Wgns2Q3BAOsDZK
 4SqPpvJQRJBBsmPmfhb9623HDK98yi5XZSanKvNEL5/z2g02nbJeMXLlZdGTbihjSLsP kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s2cabgb78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 12:55:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5D8AC100048;
        Tue, 25 Jul 2023 12:55:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5450B228A39;
        Tue, 25 Jul 2023 12:55:22 +0200 (CEST)
Received: from [10.129.166.114] (10.129.166.114) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 25 Jul
 2023 12:55:21 +0200
Message-ID: <e8138fd1-5d1f-8fc3-e29a-547902c2ab18@foss.st.com>
Date:   Tue, 25 Jul 2023 12:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: dt-bindings: drop unneeded status from examples
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        <linux-tegra@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230725101625.75162-1-krzysztof.kozlowski@linaro.org>
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20230725101625.75162-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.166.114]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_06,2023-07-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for your patch.

For the st-mipid02 :
Reviewed-By: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

On 7/25/23 12:16, Krzysztof Kozlowski wrote:
> Example DTS should not have 'status' property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/cec/nvidia,tegra114-cec.yaml       | 1 -
>  Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml   | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/cec/nvidia,tegra114-cec.yaml b/Documentation/devicetree/bindings/media/cec/nvidia,tegra114-cec.yaml
> index 369c48fd9bf9..a6b73498bc21 100644
> --- a/Documentation/devicetree/bindings/media/cec/nvidia,tegra114-cec.yaml
> +++ b/Documentation/devicetree/bindings/media/cec/nvidia,tegra114-cec.yaml
> @@ -53,6 +53,5 @@ examples:
>          interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>          clocks = <&tegra_car TEGRA124_CLK_CEC>;
>          clock-names = "cec";
> -        status = "disabled";
>          hdmi-phandle = <&hdmi>;
>      };
> diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
> index 19a39d753aad..b68141264c0e 100644
> --- a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
> @@ -143,7 +143,6 @@ examples:
>          mipid02: csi2rx@14 {
>              compatible = "st,st-mipid02";
>              reg = <0x14>;
> -            status = "okay";
>              clocks = <&clk_ext_camera_12>;
>              clock-names = "xclk";
>              VDDE-supply = <&vdd>;

-- 
Regards,

Benjamin
