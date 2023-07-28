Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5977678A0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjG1Wsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjG1Wss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:48:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17243173F;
        Fri, 28 Jul 2023 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=fEUGYECt2oDj27bF4k63rXsW2mCx4MvE7D8wHux+uSQ=; b=gwMJMcic/WkKtR7UKySv5OXx42
        ixZdTXNXM4Qxmjp6DO00e2I/JPqbK1TD7lt2d65QuhBG5WnRXz6PtZigHz6vYyF8fK5eBYC8V2H4f
        /B5mF8D8hB8PULoU08kyzPwObYeHeLhQ5GS1zoeCryNMk7Lln3HwS7WCAdz3xLYrLfP0eEPCn2v3+
        vOp0MtjhOK9MH24cDtCRO1TNPE+SixYoq6bFe1wRxtzMuvVKy69cOryaKzzljVsyLHs76coXuGjOy
        BkyKqCK0bMWDgXn5E7PJ9Sf/OvYuekDo78iC7BFXjGeWbT1t2XKgQVnkX4iFZjruZjFR6VrwjMWqo
        BpcnfKNQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPWGI-005KJb-1s;
        Fri, 28 Jul 2023 22:48:42 +0000
Message-ID: <c29d5e28-5b9d-1327-0feb-e5ed27afcd3a@infradead.org>
Date:   Fri, 28 Jul 2023 15:48:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/33] MAINTAINERS: Add Qualcomm Iris video accelerator
 driver
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-2-git-send-email-quic_vgarodia@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1690550624-14642-2-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 06:23, Vikash Garodia wrote:
> Add an entry for Iris video encoder/decoder accelerator driver.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdf..ea633b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17671,6 +17671,16 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/*venus*
>  F:	drivers/media/platform/qcom/venus/
>  
> +QUALCOMM IRIS VIDEO ACCELERATOR DRIVER

This entry should immediately follow:
QUALCOMM IPQ4019 VQMMC REGULATOR DRIVER

to keep the file in alphabetical order.

> +M:	Vikash Garodia <quic_vgarodia@quicinc.com>
> +M:	Dikshita Agarwal <quic_dikshita@quicinc.com>
> +L:	linux-media@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/qcom,*-iris.yaml
> +F:	drivers/media/platform/qcom/iris/
> +
>  QUALCOMM WCN36XX WIRELESS DRIVER
>  M:	Loic Poulain <loic.poulain@linaro.org>
>  L:	wcn36xx@lists.infradead.org

-- 
~Randy
