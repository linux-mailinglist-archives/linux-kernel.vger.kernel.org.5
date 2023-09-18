Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06E7A53D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjIRUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjIRUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6151E8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A445C433C7;
        Mon, 18 Sep 2023 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695068428;
        bh=Rh99Y745HS8tzJUeVNSTiL1/NQWpRhbaUTZcJgozihg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=flUURrwn7KAPig+aDc7k+IjlMfkTnr3ebyeVa7ArcwU1hwo7cKdbZWq8MVgnC+G7f
         b57jXwvPQov1/1KzZQTnnSROOu8BPYuc8bpEpJl7RzLO7pWByOo7mSAMDGnurWt+tT
         1dfuB1uzXODALq9tfm5JrsVEi3RPXPvsQsp95XRwi5Y5Bgh8xU2ib5LQ8OZHjFz3zd
         rD5d19BOdgN4vRCuEHEm6qOCbUounZcP3OiZbQOyznGsII+ikzlhulbiOxgDFiNosd
         zbJu0jl7P9SvLF8ngfnAJ2sY7M6LNSrVIOCmKuCNXkMALoI/peWiA/R5ZnUPOSCt8Z
         UAcIXWjlyN97A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC1B6E11F40;
        Mon, 18 Sep 2023 20:20:27 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230918143438.2739942-1-agruenba@redhat.com>
References: <20230918143438.2739942-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230918143438.2739942-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc1-fixes
X-PR-Tracked-Commit-Id: fb95d536080e6c1db099f0023f59cd55adcc5d87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a49d273e579615ed63d0347f94075dd22b9458a3
Message-Id: <169506842795.7829.2519583286587165362.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Sep 2023 20:20:27 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Sep 2023 16:34:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a49d273e579615ed63d0347f94075dd22b9458a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
