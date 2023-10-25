Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4917D6514
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjJYIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJYIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8FF9C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 657C2C433C8;
        Wed, 25 Oct 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698222627;
        bh=KhKMCCb4QBZPaGwVmy7RtOb486ioereUy6ga837nVik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=snQUTp10aZphyIsvSkmlpRgEcZpt9XkXiZ+gQoUmc9l+nDd6gIzSR56XQZGaXsoYS
         QPHu113j7HRjP/qJPiQKM/xgiuGGJcv2kKAPAtA0cuOj+6NcDUt7S1DU8VeXZHZGpM
         hpRtb420d05mqn6QPt6PyrjM+IJOLGTx/v9OuZyXECvqYx1wvPTm13U1Su6WKGJlXb
         6UEOPXFqWMNwJi65ZO7+v2d9yA0cS1PN9CuBr6bl0NPDRG0DNnDlopXuw3KadeehPk
         lbMRZlw3yAbBVie+HFwj3DqmzPHpRSuxlvpGHkdMY1UFEBlwl3777EEyu6ke5dpEpq
         uJiyjvrMSOdnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5024CE11F55;
        Wed, 25 Oct 2023 08:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: hns3: add some link modes for hisilicon
 device
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169822262732.22461.9007651558470445369.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Oct 2023 08:30:27 +0000
References: <20231024032034.417509-1-shaojijie@huawei.com>
In-Reply-To: <20231024032034.417509-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wojciech.drewek@intel.com,
        shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 11:20:34 +0800 you wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> Add HCLGE_SUPPORT_50G_R1_BIT and HCLGE_SUPPORT_100G_R2_BIT two
> capability bits and Corresponding link modes.
> 
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: hns3: add some link modes for hisilicon device
    https://git.kernel.org/netdev/net-next/c/8ee2843f4d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


