Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D057D16F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjJTU1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjJTU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:27:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC50D65;
        Fri, 20 Oct 2023 13:27:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E762C433C9;
        Fri, 20 Oct 2023 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697833636;
        bh=Aq7Xdpuzy1eqZ9xQaNvVfqPNBPBRPvcY2exwbCHeoKA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S+rUWgksoy7Sza6Udpvk1e7RixzQ+kiV+NQK2UrqwXTtpJSrLDP/1SC76VsPuekQj
         LeD82s980GO62GoIgiFdEjk4hx1/bkwBIBS+ori3xpbv+S+AayycXjofRljeRURqV+
         rXeV1Z6SGVrsKjtHcWmH6eKC+Y/2dJRTVxP6VjumKY5nv3RsjKaGLm9ZEAdzB51fIq
         o4cV11gqCz723cqo3GvfIc6xQ1B2byeuPiLwlugYsJpomlBDdHuWEDeoifkqFRfTut
         UrzM1rgur0d0/1alc3QnyidfkC0eXIyXBtQO4Of8WPaJkK562A0G3cGksRryp5E7h5
         a+8VzGr+95gag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CB94C595CB;
        Fri, 20 Oct 2023 20:27:16 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6aaeacbf526de186b21b2061fcf3a4d777e8563f.camel@HansenPartnership.com>
References: <6aaeacbf526de186b21b2061fcf3a4d777e8563f.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6aaeacbf526de186b21b2061fcf3a4d777e8563f.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 097c06394c835be0cf21e23f9bd13ff771601b63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75e167c2f63c45317f18170c1dee1df2167098c2
Message-Id: <169783363624.7501.3395231278523830977.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 20:27:16 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 15:50:37 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75e167c2f63c45317f18170c1dee1df2167098c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
