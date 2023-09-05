Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F716792A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbjIEQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354436AbjIELhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:37:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72041AB;
        Tue,  5 Sep 2023 04:37:12 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3858B0Zo026337;
        Tue, 5 Sep 2023 13:36:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=xTreX0qrOQ8jivX3KmmeTeFgWDwnQFOPBeV+r8cQ//4=; b=zH
        aoKBjbidp/+Kg/QdJ2WI6CrCICt/P9Blwt6/UJ4kFnfyoz7JHFgJmnqHa34/nohK
        wiG7VaavvDoYXgqLgsvvt+V7k8c5eYNDTCTKP+gmdRZ9j9IgEcjl2Rc7VO93NMF+
        f3DcJdcNsZ5KwylR/DDBREF1Q8/k/jCOb1Skr9rRyLvD8NToSf+AMDjuTp+dOTvr
        xfKAH0BCGUcvmQpDNIgsEjzPxbTnf6H/iIzUiGZnl/k9YY8Ah8a6rsyXKvoi7mt+
        iU3OxHmk//hpUMYLVFVK8o9XzkCFq5icXX/QOkhmVI82PMW1xSMHYuXu0aNV3DHj
        p32daEkRh8yxREvNzQgg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3svem0hfxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 13:36:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95AD1100057;
        Tue,  5 Sep 2023 13:36:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 84F6D23C685;
        Tue,  5 Sep 2023 13:36:51 +0200 (CEST)
Received: from [10.129.178.32] (10.129.178.32) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 5 Sep
 2023 13:36:50 +0200
Message-ID: <f5abe08e-4dec-1ff0-ccef-9224e3ab7b6b@foss.st.com>
Date:   Tue, 5 Sep 2023 13:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: stm32: stm32f7-pinctrl: don't use multiple
 blank lines
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230904180341.923038-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20230904180341.923038-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On 9/4/23 20:03, Dario Binacchi wrote:
> The patch fixes the following warning:
>
> arch/arm/dts/stm32f7-pinctrl.dtsi:380: check: Please don't use multiple blank lines
>
> Fixes: ba287d1a0137 ("ARM: dts: stm32: add pin map for LTDC on stm32f7")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>


Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>


Regards,

Raphaël

