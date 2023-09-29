Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34C47B3A73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjI2TPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjI2TPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5279CC8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:15:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73BF0C433C8;
        Fri, 29 Sep 2023 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696014913;
        bh=F2fwHp2G2UWjujD4j+jNDesMDV7SSkL6P1XyJZeMlMc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W/ZVurQZOSut7lYYC+4HEuS40nbxIC4+4G0G1S1bxALWOuCKeUc/iTEAipyHoic/6
         eIa3xb24nK8c7VCRn/3kdLsQhaEy0O89G/JuTLwCkzqdMoVNiBRlkRED8XZcqhOdfb
         xUcaTkFLcxFCutU+o26DCFUix9G7xPFpVQJzYxd3CfuqE+hbNcJoXnbQSDxIY3AOiy
         fv9NuEkSLMLdJFsn5YS8pb1n6Ux6dQ65WzbX7paKsgwaxolPSBCHkkxy06josHWT5G
         qldsdcVbQdpxFmVNoZ6YYS2sxTW23sj+mGpU6CUuzowlCcDbyk0LjQPt/cTXBix1zK
         q/VbttR/FtryQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D77BC395C5;
        Fri, 29 Sep 2023 19:15:13 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70699482-f413-d7b8-6378-48bc915d1ecb@suse.cz>
References: <70699482-f413-d7b8-6378-48bc915d1ecb@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <70699482-f413-d7b8-6378-48bc915d1ecb@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fixes-for-6.6-rc4
X-PR-Tracked-Commit-Id: 8446a4deb6b6bc998f1d8d2a85d1a0c64b9e3a71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c84724ccb1a9f6eaf727ded49dd7e22ac62cc5b
Message-Id: <169601491337.23736.5581455098554984692.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 19:15:13 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 09:52:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fixes-for-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c84724ccb1a9f6eaf727ded49dd7e22ac62cc5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
