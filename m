Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553237B37F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjI2Q33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjI2Q3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496D1A5;
        Fri, 29 Sep 2023 09:29:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88306C433C8;
        Fri, 29 Sep 2023 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696004960;
        bh=eI1AgvOCa0wz4SdHF2oq/gYpRepL6fWNxOG12rqIriY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WS2QQQAVEIdX9xP+vX5SaxKiuuzR4JrS44S3wECevx7V7zeArxfmChiH3or4QGKqB
         epWXa6B9FiqB4PWipiIikvgZ6p1GPVEK4r6hJLSTnCYNLgipDzU3GLM4p/Pwneat5P
         IbI3+u4u2XLen/63FD5qNJuxKX/WhKtP7aNOYiOOkgqTCeBhuL7XAo10vZ1Q9DGomf
         kfPX5akJOvjkx1e1lNNKaG1l/1A11Wy8nzZUGese+XNrQaoPgSxWreWtkMVzSLBhZp
         IEghX2SnUkwPc+vl54UCPmROEzuZ0/OvaRecX0N/4vB7jYqG3PTdMVbSFW3X2AEebg
         iC8NphwbczEnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BAA8C395C5;
        Fri, 29 Sep 2023 16:29:20 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply fixes for 6.6-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230928232058.twqyaqzrwqsrvjmu@mercury.elektranox.org>
References: <20230928232058.twqyaqzrwqsrvjmu@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230928232058.twqyaqzrwqsrvjmu@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6-rc
X-PR-Tracked-Commit-Id: 488ef44c068e79752dba8eda0b75f524f111a695
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94b7ed384fa9d397ff0aabff76a8de2f7e107144
Message-Id: <169600496043.31534.6841759201221315862.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 16:29:20 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 01:20:58 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94b7ed384fa9d397ff0aabff76a8de2f7e107144

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
