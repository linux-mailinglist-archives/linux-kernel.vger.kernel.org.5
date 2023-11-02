Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B47DF1DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbjKBMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjKBMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF3DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E988BC433C8;
        Thu,  2 Nov 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698926424;
        bh=Z32Rs3pGCBmghy3mdxI1n1S0eXbTLmN7BHJA9eLZN68=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L0XUspGDU/fsERrq9n2OH/zzwAjTetTHMp9Lmfh0e8y9BXx22if6L8P0fkdIedS0w
         /POEcMBKI87OQA2dHrVgjS5Gm7ZdT8j4yeKp7Na+FWUC3zg84le5rAlRqW4bLS+Enr
         JUuwim+nzjyiuCVoFR99OKmn+I9ZsJwoGP2B2/RNOHdAImaWbYVX2b6pMTc9m45KM3
         y7Lc8xyF0PqL7IWkvlKT/mWdmgAR/r2jkMSQVzweTfjAupvJrShX8iuZo0B4N2Ljgu
         TsM8lPQUhnpPmxrqJiEAd+dkVHkfxlo4a6UmKS8snoFd6QUlFglbRaqrjurnXLudFL
         RBVJJgYMiR0Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2154C4316B;
        Thu,  2 Nov 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix documentation of buffer sizes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169892642385.2809.13321976556181124228.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 12:00:23 +0000
References: <20231030170343.748097-1-gbayer@linux.ibm.com>
In-Reply-To: <20231030170343.748097-1-gbayer@linux.ibm.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, jaka@linux.ibm.com,
        wenjia@linux.ibm.com, tonylu@linux.alibaba.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Oct 2023 18:03:43 +0100 you wrote:
> Since commit 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to
> specify same buffer size again") the SMC protocol uses its own
> default values for the smc.rmem and smc.wmem sysctl variables
> which are no longer derived from the TCP IPv4 buffer sizes.
> 
> Fixup the kernel documentation to reflect this change, too.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix documentation of buffer sizes
    https://git.kernel.org/netdev/net/c/a1602d749097

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


