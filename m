Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663480ACAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574642AbjLHTKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjLHTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:10:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C71712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF946C433C8;
        Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702062623;
        bh=7c4U8d/Xgx5YOWv0MnWoDPrbyZJ91k09ukzZsFs3nSs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=omo4m+6uZx9SDOvRrAxc4vuY+foGN6w2tumE7fEQPT1W8FYczmhU9n8YWPpd+ndjf
         Ytmm/zRfFAHeDBtXVyOxKYSpgTWn50obThklagyugPyN6rqT25kFtRQJ/6iv75OBDH
         BxpA3X2wspzWDr4PgjrzRZ1V2+pS03cRyO/DlBAnzCYWwMSAChbXQrFH1L7Eh1GMLQ
         qf1oRFHMpvvZygKJ1qjFbJD7jUBdkzBcx8wdyQEqJpBIGHxlhtuCZpcH8k5uqaMlOR
         YS8lZ4fm7Uab0L7NWmwLDCI/iTNWGoRlTBCUvt7pgfsSBQslRfcBa8/riWpUrSJeKK
         uMjaez5XBAMqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95D73C595CB;
        Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: use DSA_TAG_PROTO without
 _VALUE define
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170206262361.18001.17068135319214332459.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Dec 2023 19:10:23 +0000
References: <20231206160124.1935451-1-sean@geanix.com>
In-Reply-To: <20231206160124.1935451-1-sean@geanix.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 17:01:23 +0100 you wrote:
> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
> DSA_TAG_PROTO_LAN937X to improve readability.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - removed Fixes tag
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: dsa: microchip: use DSA_TAG_PROTO without _VALUE define
    https://git.kernel.org/netdev/net-next/c/cf02bea7c171

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


