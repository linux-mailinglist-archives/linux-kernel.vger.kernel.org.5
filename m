Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C377F64A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjKWRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjKWRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF403D53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D322C433CD;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758826;
        bh=FvTcFGdL8EM0GPsWwPRvCVD/NzmnOuJxQCI1KGpza40=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IiF42eD/jiBs9TaoiaHIhLbpzrx9VgYxuGEUS/26W8+bDx2T4yhhA06hJVdo55z2i
         jsl3MSii0ySB9RuDr5qKZJ1mrjbr1qCPn5QKRRMeefJBRFjYCG6gkfYJGHDoRrxEF5
         U9BNEiCvShPNASe7vghWqz8VJNOMG4hlyBGXogPsi6TDDTJk9hINVdjRDfmYJEY022
         ubLJUjfoKVtJzYzOKnF9EqspW50vbt1+pjP8ylRHWqupWMN1i6fkiM4DsMReA22W2j
         Z6AJmT3VbVDxATe8s7nQkkf2kSqJqOyZxVm6AT8tnckpdzyhMU8XRGeTlpPwF4k463
         wCeYPIRZ0JDBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C2F7C595D0;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipa: fix one GSI register field width
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170075882643.541.6637672358181350446.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:26 +0000
References: <20231122231708.896632-1-elder@linaro.org>
In-Reply-To: <20231122231708.896632-1-elder@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 17:17:08 -0600 you wrote:
> The width of the R_LENGTH field of the EV_CH_E_CNTXT_1 GSI register
> is 24 bits (not 20 bits) starting with IPA v5.0.  Fix this.
> 
> Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> v2: Fixed erroneous commit hash in the "Fixes" tag.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: fix one GSI register field width
    https://git.kernel.org/netdev/net/c/37f0205538ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


