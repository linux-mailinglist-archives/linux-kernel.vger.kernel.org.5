Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8F78CBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbjH2SIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbjH2SIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8AB7;
        Tue, 29 Aug 2023 11:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B16623B4;
        Tue, 29 Aug 2023 18:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A6F7C433CC;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332486;
        bh=yZDrS4gwI7Rt3+89dF3Quz8DOJV+Z8sVRzWJo1gAkYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pWV4226wwlFLeMJJcwsquhFwx2U0P1xCLJPomuJb6AIPN8ZvxVvy0OxGUqiXMgHbd
         P4ZqjunQvOyhzNQl/lm71GgFQGdem3+a8BbRIJKb6WBPMOrDSE7gG+xzpWih94pRZt
         bQBAm020liFLzChvxYcrvngGPq8hpprWG97L4Q6kee/KG4ab4EAT+uhsFBCc60OFr5
         0+dnoKOV47u6fBa6kIEGKyIID9qQ9FzCBtCRmaFlhPoxqA9BQqhByimOPLfYku+K03
         gkDHm8koPW6wXDBTTxnKIlhlV14AoCE/cNl0Dafr/izNR2LiuRo7JVkJxRhQBXsH9V
         g5iLZNgzV4L0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 583ABC3959E;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828121549.285925-1-ulf.hansson@linaro.org>
References: <20230828121549.285925-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828121549.285925-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6
X-PR-Tracked-Commit-Id: 98ac9e4fc07f101c435f1ab6b395b6245b096a68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 995cda62100e1f50b0f0c5b793c672f50baa6241
Message-Id: <169333248635.16601.13999942683180786211.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 14:15:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/995cda62100e1f50b0f0c5b793c672f50baa6241

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
