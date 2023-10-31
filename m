Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D827DC609
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjJaFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjJaFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2511B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B67C2C433B8;
        Tue, 31 Oct 2023 05:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698730963;
        bh=fXjJabqEutx6kAr72Ev7BNb6tL822p/XDSi4+ZXat88=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kg7BX7z9STCHjkf7As4hHviQsgO7grGMFJo6K2/VPzl/7LUnOOaetkJvcnMoIx9UK
         XmZ83GSrr90hzeviKid2K72K+5yJNdncmA7oyXdSjvXaAFV9jeHLTbz2N8uBSe6PpE
         qFd0n3COaLThmyWUX1yjsV7G2BN2TfZ7orcz+34XFN32gNWgWLu8PbAPNEeFn9NeUw
         AjX12txv2VDS4HPqqVBF/2aHpbyx5k82V88uYbByeEuckRKsy7TDJfKGSo+WKESopW
         /PwdDvi/OC/p+UbJe35Dp9SkUASUfI6OQV7c/otC8evaEZoUb6Y+IqbFHdBHeSwCQ6
         M8ryZETK02gIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4B75C4316B;
        Tue, 31 Oct 2023 05:42:43 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7f4cd48e-492c-24f7-6fef-e3b50eace6ba@suse.cz>
References: <7f4cd48e-492c-24f7-6fef-e3b50eace6ba@suse.cz>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <7f4cd48e-492c-24f7-6fef-e3b50eace6ba@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.7
X-PR-Tracked-Commit-Id: 90f055df112162fd9e093c16be1c21f38c35b907
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdce8bd38037a4a2b2961ca4abffaab195690b30
Message-Id: <169873096367.17204.4045017742877657426.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 05:42:43 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jay Patel <jaypatel@linux.ibm.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:38:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdce8bd38037a4a2b2961ca4abffaab195690b30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
