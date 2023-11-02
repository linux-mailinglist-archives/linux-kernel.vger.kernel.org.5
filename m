Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BC7DFA0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377322AbjKBShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377308AbjKBShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E5A128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:37:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E39EEC433C8;
        Thu,  2 Nov 2023 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950269;
        bh=uoSyNnn8TnPOudI/MAFSQ3CG1Cmr0JQndA9X3SCZFsQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KsJ+Ic0D8RitkITUhM8yYhX8ABC4dfmWy4iNq1RjYd1LgUl4CxDl7p8fi2AGYBIhW
         3VRejO4vY07KFc8DMg3fvMlQ9nN47freI1nL9JLgMiqr6vBLEy9ZkZgtNswYX14+ck
         JRHU1ou5oCw1FHgN7S0hssG47LvLx9WErmgl5YThcFJWElUnw95JSFsfzOGYJoiCUg
         r74mOdilEbwu13FiGa7ab87RtUeqxnAsOenNfmyNtzqYitEUPW95QSEM4OpG7JI2DP
         Qkbu14SC4AxtvoPBuOuGOMMwB23lqTGK2I60fuKV7pV6o+lx+RLGwo2ORGeizp81Z1
         7eR9ai7oyROkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D28FBC4316B;
        Thu,  2 Nov 2023 18:37:48 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUHVoP/682uPjvfj@debian>
References: <ZUHVoP/682uPjvfj@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZUHVoP/682uPjvfj@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc1
X-PR-Tracked-Commit-Id: 1a0ac8bd7a4fa5b2f4ef14c3b1e9d6e5a5faae06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87a201b43bbe14ddf8dc2d73fa15741b7403afc3
Message-Id: <169895026885.19486.11527466095548971454.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:37:48 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 12:35:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87a201b43bbe14ddf8dc2d73fa15741b7403afc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
