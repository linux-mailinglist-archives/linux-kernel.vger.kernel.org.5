Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5897C91CF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjJNAak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJNAa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8253CE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E119C433CB;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697243427;
        bh=kka4h5H6MNoNDRLvZIC1Gs2lNLdFOAwO3RtrAL3a8lg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WE+TyKGgGB1r8et4pkPqs+rM1gLWU+f8C9sGVBtexXaRWyrJOF4WVwjzXmYxqVoV/
         dEY7OzCAoxG2G7r0tyY+0farWRBSQw4rr7SGEP1kSnm3e+rq94UgeH754afyPV861Z
         XlnBSYIODE3Bg0nvuOl7brRg7HGP39+fZ1jghE3iuSB666iMkM8jR2jvPuIrPGJcrq
         7p1Iqo/rb76dDMy4/1RPjQmXiBRhNXWEVJQE3s+tuMR8aov6rIxL6HnKK0KUZ42Siq
         3XEMRPQ1n64hLaQagH/M9dA1nVqwEK+9uiMqzeZb0Xj7T67WsiFYfy7BjjmMWLwFTd
         XHFMU7Dtz1igw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04A02E1F66C;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] net: netconsole: configfs entries for boot
 target
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724342701.24435.1025905471461735213.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:30:27 +0000
References: <20231012111401.333798-1-leitao@debian.org>
In-Reply-To: <20231012111401.333798-1-leitao@debian.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, hch@lst.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 04:13:57 -0700 you wrote:
> There is a limitation in netconsole, where it is impossible to
> disable or modify the target created from the command line parameter.
> (netconsole=...).
> 
> "netconsole" cmdline parameter sets the remote IP, and if the remote IP
> changes, the machine needs to be rebooted (with the new remote IP set in
> the command line parameter).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] netconsole: move init/cleanup functions lower
    https://git.kernel.org/netdev/net-next/c/28856ab2c0b5
  - [net-next,v4,2/4] netconsole: Initialize configfs_item for default targets
    https://git.kernel.org/netdev/net-next/c/131eeb45b961
  - [net-next,v4,3/4] netconsole: Attach cmdline target to dynamic target
    https://git.kernel.org/netdev/net-next/c/5fbd6cdbe304
  - [net-next,v4,4/4] Documentation: netconsole: add support for cmdline targets
    https://git.kernel.org/netdev/net-next/c/7eeb84d89f2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


