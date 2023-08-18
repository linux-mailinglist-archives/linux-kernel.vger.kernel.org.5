Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84D781563
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbjHRWUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbjHRWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E974215
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472E362372
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 22:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1026C433C9;
        Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692397227;
        bh=YNlQRxa/mKyD8QS/GUbr6Fdj6pip2WDQvxzOzrid+S0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ARToZ2lDFvUNHxQ2H7E1Nq74OiPbLEDZfrQz84b7RkoNO9MFN5Pz6TsQEZS1qp9He
         H0xpDQhGusTJw9vgPplxyVW9OmAoYyDvYx7ZxsSjfkfgqF2sktFvd5VogFxMEaYhLb
         YSjYkxlT7iHVuzqOWQx1CvQVAegwx2wwMN2wPGBQAI5lRJJ5fsLNQXRyJjgTUAMBnv
         3CZwe7Bqxu72WtlpPkI8kpPneaAt0rX1Eg+u0ea/qcwgxArzeV+9l2KKlzA9PZ4BU+
         d8ZkWPFkzdYlkGQZdJDTyDtpZzAB64TsxEg/3Lty2d3gW98V5niX6m4MYmV+QxkqkK
         lxPCeMBdzU9zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83320E26D33;
        Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: Remove unneeded semicolon
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169239722753.24641.8158983251543000115.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Aug 2023 22:20:27 +0000
References: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 08:49:44 +0800 you wrote:
> ./drivers/net/ethernet/sfc/tc_conntrack.c:464:2-3: Unneeded semicolon
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/net/ethernet/sfc/tc_conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] sfc: Remove unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/5cce781484ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


