Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951067665D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjG1Hyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjG1HyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1294173F;
        Fri, 28 Jul 2023 00:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BAB762035;
        Fri, 28 Jul 2023 07:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE90BC433C7;
        Fri, 28 Jul 2023 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690530863;
        bh=O1cNWXEo+9YOHgwHktZITvHAmMXU2sDKw5f8LCDKsEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGGC/2vlpzLcRfPtqNVhu8REJqrZ9oHbnDRVcCaYv/csppwg+D3IpWHxZVz05hDTg
         PEb52eabt+Hzk7wvDNoAYBmnXlQNiCzrxKaEV0Hgu0dZ0Dn7yx8qq+TWLHTHZO9RR5
         d8faLTTaj6BW1Qq6BqxASzOuS89qlTOdAFgP5vNc28FoaqxDWL4KHREpVMoz5pNQN6
         1sDzXe2zwPIhD6Q/DYDdMV8Yfl3A96wSFYyAcTRc5+yr4+GEP/Ne59P7i48jzFLTC2
         E/XFNKehofRueCgh4oMEObSOZoZkHoRCWKoMyznYKevJ0m5EdPNUW5iFQtOTZXjtNW
         Bmq8QmP0sInUQ==
Date:   Fri, 28 Jul 2023 08:54:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] treewide: Update Guru Das Srinagesh's email address
Message-ID: <20230728075416.GC8175@google.com>
References: <20230728001622.4938-1-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728001622.4938-1-quic_gurus@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023, Guru Das Srinagesh wrote:

> Clean up my email address as the codeaurora.org address is not used
> anymore.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-

2 patches isn't exactly 'treewide'.

Anyway, since there are not dependencies between the changes, please
separate them out, one per subsystem.

>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> index 2c8cf6aab19a..6b80518cbf62 100644
> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Technologies, Inc. PM8941 USB ID Extcon device
>  
>  maintainers:
> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>  
>  description: |
>    Some Qualcomm PMICs have a "misc" module that can be used to detect when
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index e6a2387d8650..9e4eed34dae8 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Technologies, Inc. PM8008 PMIC
>  
>  maintainers:
> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>  
>  description: |
>    Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that integrates
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> -- 
> 2.40.0
> 

-- 
Lee Jones [李琼斯]
