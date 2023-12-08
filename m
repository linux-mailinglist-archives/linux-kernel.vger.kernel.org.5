Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294A280AE2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjLHUpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjLHUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:45:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157019A6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:45:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D978C433C7;
        Fri,  8 Dec 2023 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702068320;
        bh=yRVRqAQzerPrL7IolGQXD7ZPkiuu/3qjaW3gIcHoBBE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RYL663Lrel9x4K+iecvnywW8nMmD5h4G4/dDV+CIBy+EU+95L9FDPhmewotOuf6zo
         3AiKhGoAll0S9ls7B62YHsba4UnLFZrJASt/e2hBjmcO/Nz1wU2AkKRVWyAe/ZvHbO
         DVWltcQCXhEJVcQ4B5fIcmC7NQNm+OOQVNFrYe1D8pSZLpCQ52WGlq3TMooBA5dHBQ
         +DsBwPNcDevaXcgClDSnD9XVdbCVaLWxi/B8ZzBikj6pPeGMg3eHS+45TPwtJtO8RQ
         WEYxOiuWUCBCputf4uG2dnx0w8RePJfdJLTkN3f9iWM2fpvgDxHXN170rYzqb6nlT8
         ddoFPwjxOmRzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58AB6DD4F1E;
        Fri,  8 Dec 2023 20:45:20 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231208141911.GA2934372@nvidia.com>
References: <20231208141911.GA2934372@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231208141911.GA2934372@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e3e82fcb79eeb3f1a88a89f676831773caff514a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8aa74869d2e9d868b1c4598eecc1a89f637a92cf
Message-Id: <170206832035.6831.1964570469740054207.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 20:45:20 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Dec 2023 10:19:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8aa74869d2e9d868b1c4598eecc1a89f637a92cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
