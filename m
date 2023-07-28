Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE304766B18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjG1Kyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjG1Kyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF472680;
        Fri, 28 Jul 2023 03:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48323620E8;
        Fri, 28 Jul 2023 10:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10DC433C7;
        Fri, 28 Jul 2023 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541682;
        bh=GrVo5rdpC3v6HS0sIdUz8Rz5/UMGf7Gur3+ENNLuLvE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=IyRtGeBrBtzXwNMYwNT1RVORrQN1IGXgDCmVBm9XIhf/0Dfj9zzEtbQy5GIluUqcU
         qll1FW/qh+Vh5VpaXAV2/cdK9NiPQsWgr/YSx0MPlD3g+l5XMmONd3tFMD7zifjZvo
         C6LvxkkQzKLr6IFcP+pdxwO9aqHiFrSVN8uVp1MAwuzWjB7GxHrFQaXBRtVAXvsF9s
         Y5JQrSoRdJL21y7c7d2gnHA9ZdUc/JKMNFc2KLZJTvJNVXWW/WTbce8rXOu5ye/zgz
         9EF/B9yarjOZOHsJgjmCnbE1UtI1G7ghgzCMC9DiUskbDhF+PphGVy9RTRVelmBpH0
         E/vQFc8gpqXew==
From:   Lee Jones <lee@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720083525.73622-1-krzysztof.kozlowski@linaro.org>
References: <20230720083525.73622-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: qcom,spmi-pmic: document
 PMC8180 and PMC8180C
Message-Id: <169054167957.335784.17462397007717489314.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 11:54:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 10:35:25 +0200, Krzysztof Kozlowski wrote:
> Document qcom,pmc8180 and qcom,pmc8180c compatibles already used in DTS:
> 
>   sc8180x-primus.dtb: pmic@1: compatible:0: 'qcom,pmc8180' is not one of ...
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: qcom,spmi-pmic: document PMC8180 and PMC8180C
      commit: fbf6784f7bab600edc890e61438bb2674ee1ef66

--
Lee Jones [李琼斯]

