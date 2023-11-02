Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1A7DE928
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKBAB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjKBABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:01:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1F120;
        Wed,  1 Nov 2023 17:01:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70E1C433CA;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698883280;
        bh=hk+JptQnsi3+CLAj91MWgAhCkNlKk1I1hUdBp4uw6Xc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=crInoIQQcxb2FOAnyjwJf8iovNlaoHiUDR9R8DuLBKKARCRWH0gmqKRXF4Rrgl9/H
         c2khX3OgXPJQItNiFtPZ5yqlgOSJM9zjRvkyJWc5OjcsZpFKveOlceLKKfQI9i5qlX
         sqAH2SUgh49zYwqmNmQcWcYDM60ZZhoSf5+Y1xq2g0VWMHy+r5piBjYzpJNFjt2rbh
         XdzPnunF1M4NrZzZVVDnncXe18yy/bbd5CnjCTSWJL7RmP7KTi/q/7ot1pSMIK9RoP
         TMbp6eIUt4XYXSJV09eibDZu3xNZtkXUSHevVlJpazEsLmTx+AD+FmERiiMaoGl9k4
         7X+VhlVH7rYyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2918C4316B;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101102636.5155-1-ulf.hansson@linaro.org>
References: <20231101102636.5155-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101102636.5155-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7
X-PR-Tracked-Commit-Id: 5428a40a308f220dbbffda66cb01b212f88e9a06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40aa597c4a53f7269367d1b5298bd44afcdcf473
Message-Id: <169888328066.31464.3283208532679720508.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 00:01:20 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  1 Nov 2023 11:26:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40aa597c4a53f7269367d1b5298bd44afcdcf473

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
