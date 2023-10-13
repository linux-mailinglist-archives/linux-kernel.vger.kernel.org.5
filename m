Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DC7C8D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJMTG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJMTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:06:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E595;
        Fri, 13 Oct 2023 12:06:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43930C433C7;
        Fri, 13 Oct 2023 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697224012;
        bh=x6bY2c+afWhsrTOWxLvHn69OCkXKmxSZU5qbCu8jqVI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SLVGZSI1e3BA8pPyDW6XWIIhlM6ezjhCJGoU+rADATm/g3XEkyYSVZRmOLwbzLkW4
         3nCkL6yucjCgSf02UksEaVaztxnef6mOuTObisL1zoJEG3jSMzSCfJJzzJuqUJIAV+
         T0AcoDrfPD7ruWp/+gUIhk8k71DPxUI+n+3HpvwLQRtvzs4svMgApCQc24qWCoaVrb
         aBJqoiNwBhVGmzUwWEW8e5YJqA3hy26vSjSa1Ly5WWsY2XQgEtEv39unJJc7WP7N5x
         gsNopwG3wlXg67+99oVpXXN/GWZJVNtw/2iT6LPowuJD3VDOaa5AgaZgUqWt2j23ae
         5Zkuh2QHCDwog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DF80C73FEA;
        Fri, 13 Oct 2023 19:06:52 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231013153544.463041-1-idryomov@gmail.com>
References: <20231013153544.463041-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231013153544.463041-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc6
X-PR-Tracked-Commit-Id: 07bb00ef00ace88dd6f695fadbba76565756e55c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1ef447deed5f5add172cd83efa48c46cb2b1a0d
Message-Id: <169722401218.18973.5440216269263110.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 19:06:52 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 17:35:42 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1ef447deed5f5add172cd83efa48c46cb2b1a0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
