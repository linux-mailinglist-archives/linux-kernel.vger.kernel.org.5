Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EB8099AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjLHCxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjLHCxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED51984
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DFCC433CC;
        Fri,  8 Dec 2023 02:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004005;
        bh=p/RCldjZZRW/Un9LSiHaH+jm6ogwI4wQ8fFrT2ZAQiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzowJ7nssvV1gX/vye/WmHpllsRbULq2fRH7pkGhuO8l4g0oawCEqQUk1TzkdtrQX
         Q4mTQfFzOKox3M1Jjhu3jgxLB6WGlfAyEdV+VhlvGd5tPdYzCCWza752yMaNowvZoo
         QE1gA+G0soE/X814jL2hJTTUKuJPvZcHZDF2hCY2XL4vp7NZKcHmQLWn+ehHOS3poS
         xURjlYBZ73K6+HFrKQrAyRt7rqJo6+v9qhHbnFEF0goXyL5tbF1N2s34u6EOG/rP8x
         kM/pZUWdzf6CnBVGJWJn+pVt9qhUWk4lezIxhYYY7A5vFZ4LVxSJk5CpHiyULU8pHo
         DvSUsJjxZ0Eug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        Alex Elder <elder@linaro.org>
Cc:     mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: enable IPA on sm8550
Date:   Thu,  7 Dec 2023 18:57:29 -0800
Message-ID: <170200426936.2871025.13229395698754842042.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124181718.915208-1-elder@linaro.org>
References: <20231124181718.915208-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Nov 2023 12:17:16 -0600, Alex Elder wrote:
> Add the basic DTS information for supporting IPA on the Qualcomm
> SM8550 SoC.  Enable IPA on the SM8550 QRD platform; GSI firmware is
> loaded by the AP in this case.
> 
> 					-Alex
> 
> Alex Elder (2):
>   arm64: dts: qcom: sm8550: add IPA information
>   arm64: dts: qcom: sm8550-qrd: enable IPA
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: add IPA information
      commit: 32c5a8b93ba543e3cc596b0272b5ed7fac82278c
[2/2] arm64: dts: qcom: sm8550-qrd: enable IPA
      commit: 33eae059ccaf71f6243dd919add405dfefd275e7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
