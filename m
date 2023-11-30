Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C77FE843
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbjK3EUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjK3EU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:20:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F49D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:20:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C4F0C433C7;
        Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701318034;
        bh=cCbxWq0+NPkfY4QA9+yYjFe6vWIYbmPWSXdcfESV6FQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D2gb8qahivfMLNRgtbckYeMOPP7mTefC9L6uKpLMNbV1D1lvdOaUERpG1w/S4+AFJ
         CxTNS+G1+4mX4wqS63rx4+u9ocP7u9zXw8jr25CXDnE8+1ifrXcABi1/D+kXcNeI8Y
         VQkbUpWT64i+9qNIusddSYYcToUbrtCAma68M9D2amZ6J2KwzZYIHDTdFIZFZB8C85
         mr10+WfXixqwtIGZEkhrccf2NTPz6nCkjiTk3ert+8q/6835CMympQhdpvlUn7Sm7M
         w86WVgzo4amVCarDuemfcOV7Et4hhITSMdAVxpttZBfBLdtHDqvat8+9rPibbn0bmC
         eRYJKbZ9G8Xng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEF2DC691E1;
        Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: mana: Fix spelling mistake "enforecement" ->
 "enforcement"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170131803390.31156.8118713082387306465.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 04:20:33 +0000
References: <20231128095304.515492-1-colin.i.king@gmail.com>
In-Reply-To: <20231128095304.515492-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, shradhagupta@linux.microsoft.com,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
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

On Tue, 28 Nov 2023 09:53:04 +0000 you wrote:
> There is a spelling mistake in struct field hc_tx_err_sqpdid_enforecement.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c      | 2 +-
>  drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 4 ++--
>  include/net/mana/mana.h                            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [next] net: mana: Fix spelling mistake "enforecement" -> "enforcement"
    https://git.kernel.org/netdev/net-next/c/f422544118cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


