Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31597DFE0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjKCCU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjKCCU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E161A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D14C433C8;
        Fri,  3 Nov 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698978024;
        bh=vQG/1KfPyp0tpJGPUCsls9XsSFs6pXv6NJ79Zz0uIFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lmGqiI9oI1MiiF1jzGJXLFNv75W4TuIsdyAmLl0LbhmaWE6PH1pOemY5aWo4Gl6De
         M5CAEUdlNDb0nG5jqDjZmG/QJ3q43D8hE+tBxVbHaf+kLx3zcvxMn49L4u4FyRMHqk
         whk8XBNJOfq3Nwi+JcrU9F01fEsEjjw1BOWuT8m/a50upO9PbWuV7AB3gmK6jOxQyF
         1dy59nDUGC7qFboHaFpWwIRsjnvHkgtc5VEytsp3wWShcSRa0JoBTEXqBCw3tJSeJc
         VhmbBdgEbX4jevOzHHeYVDjzahgkf3nrS9pS9URQ6I4cRVg4Lj6mpUy+bSmVYWfH5P
         92Qfw3lfqEITg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B79EAB08B;
        Fri,  3 Nov 2023 02:20:24 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 6.7 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102172917.142863-1-pbonzini@redhat.com>
References: <20231102172917.142863-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102172917.142863-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 45b890f7689eb0aba454fc5831d2d79763781677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6803bd7956ca8fc43069c2e42016f17f3c2fbf30
Message-Id: <169897802435.29625.14357865463439364819.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 02:20:24 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Nov 2023 13:29:17 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6803bd7956ca8fc43069c2e42016f17f3c2fbf30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
