Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C17D2CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJWIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJWIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A28D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD0F6C433C9;
        Mon, 23 Oct 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698050422;
        bh=7K+dMddgIAudi/Xn6O8edWOR81jrB9lTM0jGIiW7u78=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gp51Iw/y3sQHBiz2dRQIZSjCG936URQ1Gc43AePYf/KN7KcCVSNmf0c2iEYwgjGYZ
         lFogx1bWTftSGDw0B+NmTzzHUTxP7MUerhITAT6Y3xmoMEUS2/u7HNmakmnqJhUo78
         BJLowdXaeQPSjv9ClHM6M9IOM3pbbHD0YVAJ09/hzj4aWqnWQ/HcFbftXSW1UYrwG4
         E6qFQWbFzFEVJqG2wZdX9UNjt41MQKnY1EkjiaTvtOdL2a7r1SoIuFJsjZDzgOKz3I
         RFCnDKHQdcX6fDzjZWSBgwNxWoUnzplFM1+POAkizDE/vYu3DIlxfCZIXOzwaK6KeA
         n35WtX4nk0vbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90870E4CC11;
        Mon, 23 Oct 2023 08:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] isdn: mISDN: hfcsusb: Spelling fix in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169805042258.28420.13891530581677919696.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 08:40:22 +0000
References: <20231023063758.719718-1-chentao@kylinos.cn>
In-Reply-To: <20231023063758.719718-1-chentao@kylinos.cn>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     isdn@linux-pingi.de, kuba@kernel.org, yangyingliang@huawei.com,
        alexanderduyck@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kunwu.chan@hotmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 23 Oct 2023 14:37:58 +0800 you wrote:
> protocoll -> protocol
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/isdn/hardware/mISDN/hfcsusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - isdn: mISDN: hfcsusb: Spelling fix in comment
    https://git.kernel.org/netdev/net/c/13454e6e0df2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


