Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1F801A9C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442026AbjLBEU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLBEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE58D48
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4163C43395;
        Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701490824;
        bh=jWE56trVPmQzz+YfD/mLnPE1SjgGNTuR0UnvpUsNe7o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LkZzFzkcJbn2KTpvXUgzU+t654jXhocDfQZwy121qw8ciflsXCkqg/nVYtcdjj4Df
         JIOyMyHEDJqs+1BQV/j2qF2iWrYeluno0vzgI6yTD8D1SHkWX3ksqPYcDL6oHrCqrP
         +MqHmLMffWHEW6CrNmkdt0oAlEWYjHEXaRqpk2qWwlgDGZZX7EGddghpHhVy+A8igw
         t84vEK3+h7Hdu3Kd2wwtbSTGFFFJmktHT2/DlKRjvNk7vFP0X1Q0kbOU1QtdLO2Bdz
         dPsG8nCfMJ9r2NWFsbgakwUXTeisTU6hsoYwWbbmxWub2jlHk1keZUFpfjyUy5x3AZ
         PIxuGKSvXrnOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0B25C64459;
        Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: qcom,ipa: document SM8650 compatible
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170149082465.6898.10790430963543604877.git-patchwork-notify@kernel.org>
Date:   Sat, 02 Dec 2023 04:20:24 +0000
References: <20231129-topic-sm8650-upstream-bindings-ipa-v1-1-ca21eb2dfb14@linaro.org>
In-Reply-To: <20231129-topic-sm8650-upstream-bindings-ipa-v1-1-ca21eb2dfb14@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        elder@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 18:22:58 +0100 you wrote:
> Document the IPA on the SM8650 Platform which uses version 5.5.1,
> which is a minor revision of v5.5 found on SM8550, thus we can
> use the SM8550 bindings as fallback since it shares the same
> register mappings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: qcom,ipa: document SM8650 compatible
    https://git.kernel.org/netdev/net-next/c/a10859384256

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


