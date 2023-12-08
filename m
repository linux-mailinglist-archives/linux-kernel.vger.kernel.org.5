Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163F80AD30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjLHTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:38:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291A98
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:38:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6C8EC433C7;
        Fri,  8 Dec 2023 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702064303;
        bh=pfhHhbxigocqyMNuNVPN29KxhpZWLOu1W6TsIC+kwfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kB/43SuchKg3T4TURy0NS9BAJHMgJgSWKxRqf3pK/37Fbho5j6BwjfD/t5SdfG2KP
         5GZrr/2v72lz0R5ysK009INFNSgH++J21Ncx5MVM2BxlVaV+mKkHw8kRZBzL9WoHwQ
         T+xzSVLj0r7EVTjv3pvYNL3K0ASTTT0Hr85R04DYETg2c3mhmikqyQeXCeMQi6cFcf
         qXTV/LnLpWAUBIw9qt1DkaOoVzJbQ46JaS9SNSsP9hhjk40mTn2qktp7DuywAvwNwN
         tJH7HkWkjL4McMo14eTzCgjCe0a99656VHyz5UK0Usy7Vq5R2dz7b4PSLn2LguwolZ
         jPEL6PXqdBfhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B436ADD4F1E;
        Fri,  8 Dec 2023 19:38:23 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw7vc_BOsPH0xAwFvx_ZCQyZ24ofp3pUt1MQe9QA_U5Mg@mail.gmail.com>
References: <CAPM=9tw7vc_BOsPH0xAwFvx_ZCQyZ24ofp3pUt1MQe9QA_U5Mg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw7vc_BOsPH0xAwFvx_ZCQyZ24ofp3pUt1MQe9QA_U5Mg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-08
X-PR-Tracked-Commit-Id: b7b5a56acec819bb8dcd03c687e97a091b29d28f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38bafa65b1260cb774cfc0c9a3ddf82d3c563e10
Message-Id: <170206430372.311.5094699771321399720.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 19:38:23 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Dec 2023 14:54:20 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38bafa65b1260cb774cfc0c9a3ddf82d3c563e10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
