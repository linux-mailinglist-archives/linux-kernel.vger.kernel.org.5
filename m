Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7166575B393
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjGTPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGTPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF219A4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF89261B77
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F59C433C7;
        Thu, 20 Jul 2023 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689868466;
        bh=j9tqD/4jMij/dArGDX5EgMqbjxDJgcuJJMwCmVuCpEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nWjiEZCYwYMZYz0HlXf+5BpASyVzbZOBHSbHr7wTyBV8g9+XIZAPvs8xuAIuZw3yo
         kWIr6EzEXUqEuEJNpsQrErcrrGt5wnbFe/u8oRQQiFfUoj0w70qtVWb9Jj0vNm9cuU
         H1i29KClfaZkmCIRktW7yHPc2c1lvenNygsIE7nmrrWVkvOKOhV5Cw4IjVVDOJpa7h
         caz04vVzxpuIDtK54VDi7C7pCmdc4IrUZUWKXEBpMro9DaPlVcsaQLIWAcKOOTkng5
         7LTY9Yma6HrAzh/OLzsyDyEVYQHoFl6I7IedQKcurWCgi/ROCGhddWe/BqInPyfrMG
         J/Jc7HCrakK5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FCC1E21EF5;
        Thu, 20 Jul 2023 15:54:26 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230720130535.4CCF7C433CA@smtp.kernel.org>
References: <20230720130535.4CCF7C433CA@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230720130535.4CCF7C433CA@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc1
X-PR-Tracked-Commit-Id: 98e2dd5f7a8be5cb2501a897e96910393a49f0ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2922800a1803f6319e329bdbfd2962fd83eb5360
Message-Id: <168986846611.27763.8061138860946889351.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jul 2023 15:54:26 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jul 2023 14:05:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2922800a1803f6319e329bdbfd2962fd83eb5360

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
