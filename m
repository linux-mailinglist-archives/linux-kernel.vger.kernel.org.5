Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2367AF412
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjIZTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjIZTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6131A121
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A853C433C8;
        Tue, 26 Sep 2023 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695756210;
        bh=g11pnlMcj8aToX6SKClp0xXcsaaSjXTicN9VJVOZz3I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YKmSrfG4AWLgMPwDweR3l/gqqgfhD3tbn6YJeVEPmYeVEF3UhaNBfZXZp7j/lXeNJ
         DMUr0BKuEAkpOioB53UFH/7G7yilP16+ft5usHr2dSFRrnEmCFoHJI4OSODzvIVjv3
         B0S2nTlKzMg4+uicN4clMbZVjjksmpkzH7FGc8ou5olgduwK2VDJn4oguW9FfzApZ9
         wLi2ZIHuKoiPkyJmM0Bc2OoBj+XnHXI9mWUt+NKncZI3QmUE/2wdFrwQr4dQ7Ylnm2
         qtugCXO1umd5+ipxfHix6SM1m+410JaVBpw31SL3NFAwcI6DbO7XoLTcDOCHCU2/22
         DBNpSQvbe+b0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E451AC64459;
        Tue, 26 Sep 2023 19:23:29 +0000 (UTC)
Subject: Re: [GIT PULL] Workqueue fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
References: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ wq-for-6.6-rc3-fixes
X-PR-Tracked-Commit-Id: dd64c873ed11cdae340be06dcd2364870fd3e4fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e945134b680040b8613e962f586d91b6d40292d
Message-Id: <169575620992.14802.8830317166716604960.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Sep 2023 19:23:29 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Sep 2023 08:37:35 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ wq-for-6.6-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e945134b680040b8613e962f586d91b6d40292d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
