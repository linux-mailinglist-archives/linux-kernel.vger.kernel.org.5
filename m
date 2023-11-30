Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15A7FFF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377264AbjK3XY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377258AbjK3XYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:24:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2400610FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:24:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA749C433CB;
        Thu, 30 Nov 2023 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701386669;
        bh=U6pw7eD5IUkiLweoLxbArAcyN1wlQeOd/aLmgHZOjTE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MKFSx5mLN6zYS+XlJ1G2yMFerG3d1RHiI/XD2XTZfYNNWrhkA4gcYwvAsUbHnMrZn
         D2CmK7ON2TA4PHJhX1luJqsmlKOQH8QnjIr/pZTnPfEHWSYaWLN0qCWReLSNey5RmK
         BYGbK8fvac9X+dxrtrS59i9c8ufcSCCNKxIv4nf2zcK5dbvzmNknPw67oRh9Y2mygf
         mP/jq0gUWDkSPX+X2whh6BthUiyXqAMJdiEjDgTP+u0NISVpnFv6NeGWItKBUnmxhW
         Uz0BAypl9jGsB1FjCWHPaHjR1Jj9Ti5m1FZdXDcKnAU1nW8+NpFyBJcE35RIt2uyx2
         SdeDhE9SfwHSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6EA9DFAA86;
        Thu, 30 Nov 2023 23:24:29 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231130104545.62755-1-ulf.hansson@linaro.org>
References: <20231130104545.62755-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130104545.62755-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc1
X-PR-Tracked-Commit-Id: 477865af60b2117ceaa1d558e03559108c15c78c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09443a144c1642b302c9bc329eb9475ae95b4304
Message-Id: <170138666967.16887.7822667056554033597.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Nov 2023 23:24:29 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Nov 2023 11:45:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09443a144c1642b302c9bc329eb9475ae95b4304

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
