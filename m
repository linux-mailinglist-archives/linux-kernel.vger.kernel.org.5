Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098FC7C97B6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjJOCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjJOCrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:47:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1DD9;
        Sat, 14 Oct 2023 19:47:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 609E8C433C8;
        Sun, 15 Oct 2023 02:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697338074;
        bh=sHPnDtnAgu+NinMc0o3MQxOp7WkKMEovbs4go5cCxgw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aoB7gp0YE8I5lqnzJpj0mJvC3HmmmE4dXdicqVgro+5glK8pmoVIbLh+JikmNsOyz
         dWU4YnFYL2mw9U+QpqvCQmE/uRnCJ8TQj3uNrziHau0U0PM0dUJoC3pDwi/wYg4Yjn
         fwav1ENmtlfHgx/vuzw5mZXEojoczm/yzIxFBCLfBjjQ4ly8vpsv8ZEA85JnMgHv0m
         d4J9Z9t8zYSta3/O/3G1GrFXY/osIseTQjEOqN3CB0F/7A/HYSKXdnrXh117YxcNVg
         dIHUW5ISCoqNDLXMTclUfO/G1zY+oKOSFLBTwmtJdhyTNDLnnNtZMP1uUO0mbLnHJu
         eHo7a3AguwuRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CE0CC1614E;
        Sun, 15 Oct 2023 02:47:54 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms0UzM_VjC6rUjyYX5X1dR2Jxp3t9_fSoqw_0h2zqk4qg@mail.gmail.com>
References: <CAH2r5ms0UzM_VjC6rUjyYX5X1dR2Jxp3t9_fSoqw_0h2zqk4qg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms0UzM_VjC6rUjyYX5X1dR2Jxp3t9_fSoqw_0h2zqk4qg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc5-smb3-client-fixes
X-PR-Tracked-Commit-Id: 81ba10959970d15c388bf29866b01b62f387e6a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf2069d151b7bb5dfd7c7f834c016205a517c5ad
Message-Id: <169733807430.25471.15657703741943303667.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 02:47:54 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Oct 2023 21:15:53 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc5-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf2069d151b7bb5dfd7c7f834c016205a517c5ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
