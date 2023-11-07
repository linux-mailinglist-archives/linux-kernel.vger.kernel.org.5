Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE237E4B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjKGWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjKGWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E3113;
        Tue,  7 Nov 2023 14:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14215C433C9;
        Tue,  7 Nov 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699395625;
        bh=4wMvSE05QgFDXivICuVrwXjDQcxuQYyNZnNsLRe/Wqs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U2L84D1m671hY/Ehu5dTh1VYJl6f1UQlQcYxN7mpQb2Av5rwcD1gkONYvtnkP70YR
         dpI4eFzCx7bKsj6+FKO3TFoMLYNOh7lf3Nn3c3OU02gBS/eKbFOXQ0tbpPzKeg2CwA
         6aUrVBLPYWytVEZst6c6AwvNYgx/pKQvg/UNq2/EW4Xz88s/agq2Os9QOPsgB0dYyF
         F/HoaOEODPtQ2jgfseFybgxUTxEJxoh7kNpejGjlXTu5GON9kUfMq5VC78p5X+WdFW
         p5haWvxw3ZkRYI/JGyFTvGcijiyTfbX+hY7CNSoygc10jAnOcMVgo4c0eR2TFoUfJl
         eX7hIaASLZ/5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE8D9E00088;
        Tue,  7 Nov 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/qeth: Fix typo 'weed' in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169939562497.24931.15605736956129233304.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 22:20:24 +0000
References: <20231106222059.1475375-1-visitorckw@gmail.com>
In-Reply-To: <20231106222059.1475375-1-visitorckw@gmail.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  7 Nov 2023 06:20:59 +0800 you wrote:
> Replace 'weed' with 'we' in the comment.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - s390/qeth: Fix typo 'weed' in comment
    https://git.kernel.org/netdev/net/c/dbc9e341e365

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


