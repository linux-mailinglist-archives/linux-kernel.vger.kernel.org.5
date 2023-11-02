Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3C7DEC89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjKBFvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKBFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC7128
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:51:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8EE5C43395;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904287;
        bh=ecZB7l35L6wule2Au5YzP6nuUXpzn/mRCATx+gVEK+w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ea/Zol2rYjOUbJc4jjCC/OogKjouWMgfZ0cDxHL4KEj5otp+/+qh1ujDbm3eFQcQb
         bR5/mVRzg48119+n/3sDjHG1Q2uzR3646CIqToa9/SUNNo8UjpCY7rjBibJ6h6cwJ4
         YlOv+CE+b10eH24MDjwg6dh46Dg2aYX4n9utsR/2gi/h8j75DVQAZDeIvVaeeVkfEs
         b5ETgJMf+4AK6RHPfZPG72MtG3NM/j7/mJj/phQF1Lzsa0iDj3fWAQ+PhoW43fSvWf
         sOxj1Fc3YwALAPvS2yeVOXCK3qw0bJ6MLGrqQWAUnML1v8bb9JsAsILt7uYeuMxXrp
         5wWI1ByWu/eMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A9E9C4316B;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xscale: Drop unused PHY number
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169890428762.30377.1176833173380054873.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 05:51:27 +0000
References: <20231028-ixp4xx-eth-id-v1-1-57be486d7f0f@linaro.org>
In-Reply-To: <20231028-ixp4xx-eth-id-v1-1-57be486d7f0f@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hharte@magicandroidapps.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Oct 2023 22:48:35 +0200 you wrote:
> For some cargoculted reason on incomplete cleanup, we have a
> PHY number which refers to nothing and gives confusing messages
> about PHY 0 on all ports.
> 
> Print the name of the actual PHY device instead.
> 
> Reported-by: Howard Harte <hharte@magicandroidapps.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: xscale: Drop unused PHY number
    https://git.kernel.org/netdev/net/c/d280783c3ad9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


