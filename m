Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08B7AA22D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjIUVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjIUVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71996A9F3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E02FDC4E69D;
        Thu, 21 Sep 2023 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695303023;
        bh=BShjIpWFgvjzflUn62NaxZ6MDAEEhkSaVZ7cY6t6rjA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=shhEZbcKGWeQhMG5HRq+S9IpMyvRM7wIhcISX5noLYk1op64ASw0TLhkS+87OPRQG
         kKa0n2mOLdIR7yI0S774TCxfAMK58OLHYUDKGmHkQRSvcFsdTCVx6xIeTtMfky7XVK
         GHMdBfahpRgUFZvH3KdY7Fu+A6S/Pwox/uUXEXsXNRCE0sUxoDCBPeU6WZ6x/RmlHh
         rcPqo2NdNKbRem8E6QyOjgQgmFWFMWE+KxxH+FaMioiF74+PTSrqf1phWmMZG8ULAD
         Od9AyD4TahLGB5CzA8EAdkAYYPIHJHvj9LpQpOiZtcWfdxJl3nEDLPegU/oFAPAmlG
         imJ7aOgHDJVPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1D3DE11F40;
        Thu, 21 Sep 2023 13:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdev: Remove unneeded semicolon
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169530302378.11910.7112501445541140613.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Sep 2023 13:30:23 +0000
References: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        abaci@linux.alibaba.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 09:03:05 +0800 you wrote:
> ./drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6605
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/dpll/dpll_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] netdev: Remove unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/f20161cf5165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


