Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966957E1222
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 04:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjKEDC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 23:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjKEDCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 23:02:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEED6D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 20:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 685FDC433C9;
        Sun,  5 Nov 2023 03:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699153333;
        bh=FkOQSxtcywcBdscFQ07lgqhNdeUR3J/FlzQWSFZUYD4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l4SlJfWRkCtrMsEeW//JDjBlDHP5eGAzQeBkY4CFTiQCt1cxjHFju/Er5J08ii+uN
         iK46/ZsttWySu7KLC37Dsq1u78C9MCX1nevrDHX+NJFRU4y2K8ZCmXmpCAwSuL7R2R
         vR12goGkKlYREtSAdwwLMv6o1HCTRrAIsOFXqspm46X4F0YchPfT2WNzl6ciw5TjN7
         +jGrJCrkZ9FlVDW5VrHHf3k74obTQINjnPVXrMY8U2i72Bb4kxgWgYGx++TdIkVm0y
         YoOY0l7uRhvMGlx2Tk9pyc0FylHL8ArtI4IfsMn9xJKgNHNYa8GLkMayUfk7EkY5d/
         Z01x2t18kKZrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5723CC4316B;
        Sun,  5 Nov 2023 03:02:13 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202311042315286247d3ae@mail.local>
References: <202311042315286247d3ae@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <202311042315286247d3ae@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.7
X-PR-Tracked-Commit-Id: 9fd00df05e81a2e1080ce6e9abc35533dca99d74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c41041124bd14dd6610da256a3da4e5b74ce6b1
Message-Id: <169915333335.2133.3914857078039091532.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 03:02:13 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Nov 2023 00:15:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c41041124bd14dd6610da256a3da4e5b74ce6b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
