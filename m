Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37C7C47F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbjJKCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC7A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FFDEC433C7;
        Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696992625;
        bh=w9gu+nb5Tz52hnmU6Kk7Z7DuZ/JVvqc2nRkEOjPHfu8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eOxp8I9VrHM/hedI5giFGh94WPs1aqQg9Gcn9aINebbCqzTrZUTZXb4WOtYcvxIGX
         tbCPpyhYcPlhlyYb1k3zE53y8tiwbsCPAUSLtsj/03w+ELylCWlUQNxJhYBtcwYfiN
         JO6oeJetGiA6LcQqKaDmxsimO8UeUZxycRkBMPeXnuuADvc+1HgrM2zd2GmFnyC8Mo
         FBUBR7BONEBD6Pf+X1Z3p8gKabgIX2CQU27qBaklzSNa+RT/CgNvAPQJqSRoSP9IgH
         LUf2SQsVCjnJ0uLzD4F0YG0z8tiwtxvN70SM8XEtJ1SFSdFYmT4zNIFH06aKXiKTNH
         nL36NtS7YNuTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A0D0C595C5;
        Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: skbuff: fix kernel-doc typos
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169699262543.24203.5794008894779033273.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 02:50:25 +0000
References: <20231008214121.25940-1-rdunlap@infradead.org>
In-Reply-To: <20231008214121.25940-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Oct 2023 14:41:21 -0700 you wrote:
> Correct punctuation and drop an extraneous word.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2] net: skbuff: fix kernel-doc typos
    https://git.kernel.org/netdev/net/c/8527ca7735ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


