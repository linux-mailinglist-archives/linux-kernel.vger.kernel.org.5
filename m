Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D683801A9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442015AbjLBEUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjLBEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36248D7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE448C43391;
        Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701490824;
        bh=PEMYclhCkQOsQjmYM/8h/waI+etEhpl8PV98QdlSbok=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CNlM0e1CY9ZJ4dpvZfaaE8w6Wk6ii1Pir0PMn4+B0mZRF34dT0ORMOsP5PzvG1C2H
         +0v1oKaPsv1IFnhcpLZCeu91xOdkksWSm5tg4n9jTO5e23NdiOmJ8sdWsNRSif8/vG
         OzgfnczCNtqxJDZGQGSFGUq/vzEbgvAlcXx1nmaQJZt3pCWFfsbTZ2xz8D7XNBDKE8
         GEMohJuxgmadFoTVJ1Z9uYidM1dAO1Bg/ll5yUMefohjNQlLQTJ5qAzY+yYObvDgr7
         zEQ4IcS1pwXL8hC7J1SOZAl8zZsBTY+mN9xnRlR4jgwG1B/0AK0unSIzHsj2Itykj+
         pqh3vD8PZXAuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A91B6C59A4C;
        Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: debugfs: update CQ context fields
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170149082468.6898.10971138559604830624.git-patchwork-notify@kernel.org>
Date:   Sat, 02 Dec 2023 04:20:24 +0000
References: <20231130060703.16769-1-gakula@marvell.com>
In-Reply-To: <20231130060703.16769-1-gakula@marvell.com>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, pbhagavatula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com
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

On Thu, 30 Nov 2023 11:37:03 +0530 you wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> This patch update the CQ structure fields to support the feature
> added in new silicons and also dump these fields in debugfs.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: debugfs: update CQ context fields
    https://git.kernel.org/netdev/net-next/c/4f09947abf24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


