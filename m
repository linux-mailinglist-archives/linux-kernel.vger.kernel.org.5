Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6C7E0079
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjKCHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbjKCHNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D59191;
        Fri,  3 Nov 2023 00:13:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6203AC433C9;
        Fri,  3 Nov 2023 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698995617;
        bh=MQT82r4Df4VbpEn4+AjOR7ZgYSOP9JYKc2JSesENocg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=suH1Dji7H5eE2G/wFko2aLLviNfHVxYbgftH84bq4IYSZPPQbm0sEMnd7bbDz0bLZ
         0m73ohAv33DjPyiULX5OMWy+629JVvUa4t6SOJ9Q0EK9AL64lgp5WZO9vxtUH2Usym
         EZWsXktk+VBunI5CdWu/0ntj2yD3DAKBe6oISsSpc45aKKApordX9CKenUFv5XegOx
         fMGhbAI3lvVy/o9GDrS5l9w4573p/38p22Nl9/8I4nouGbcb1Ux9geKu19WJeAcNB1
         /VYxbIHIEdRa0BUpztognGKldaotEN89qBK6wzE9t5WKq9m+nHm+Dj2oiPhb8vwi0q
         njskEZ+Hmn/xQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 517B7EAB08A;
        Fri,  3 Nov 2023 07:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] Non MM updates for 6.8-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102143341.9e83402cf087ba82e2b4760c@linux-foundation.org>
References: <20231102143341.9e83402cf087ba82e2b4760c@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102143341.9e83402cf087ba82e2b4760c@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-11-02-14-08
X-PR-Tracked-Commit-Id: 6620999f0d41e4fd6f047727936a964c3399d249
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f6f76a6a29f36d2f3e4510d0bde5046672f6924
Message-Id: <169899561732.26157.6831376075881574476.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 07:13:37 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 14:33:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-11-02-14-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f6f76a6a29f36d2f3e4510d0bde5046672f6924

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
