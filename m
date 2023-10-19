Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B27D01C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjJSSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbjJSSgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:36:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E74132
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:36:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA8ABC433D9;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697740576;
        bh=M0IOD1bLhffOCN7lz+jWIRSmTB9VtAvHCtNSB4MsfIQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dJxKvPeEGS2do7WL0z4DQxHInZipw4qsKzQ6tADAwQWBWXJ6Y+LYFdKH9iWLR5Rni
         +btMHhPbfGBKdIujcr8rdJJBWU5TwViwOM78EuTPG4zZ1EcL8nUrmcRRj7G96fMQgl
         PEr5ZPJfVEpWwmuL0/1hn400xBZxr5o4lCKmZ/ggdFI6956CP6vfoHJ0D55rxNGAb2
         6mNy4mvKQcdfiriqNBWMJ1cYe6qRVwIo7HIVqXsTMPVuDu6pf2Tiizjheh3s1IladR
         BA5VJOIb3oYGdzRbqO7sADMyu29WrrVSum57WOVDxTC9KJ+Yyv7eHYK22HfasTC4JJ
         vOuqpeqMcXz5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C384BC73FE1;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <06eb77e9-a058-6b0d-d0f6-2f4733e6ca00@suse.cz>
References: <06eb77e9-a058-6b0d-d0f6-2f4733e6ca00@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <06eb77e9-a058-6b0d-d0f6-2f4733e6ca00@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fixes-for-6.6-rc6
X-PR-Tracked-Commit-Id: c15cdea517414e0b29a11e0a0e2443d127c9109b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54fb58aec47a49a80534d2ccabd319334d6b0ef8
Message-Id: <169774057679.20290.12852615009577377755.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Oct 2023 18:36:16 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Oct 2023 17:20:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fixes-for-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54fb58aec47a49a80534d2ccabd319334d6b0ef8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
