Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01C7E00CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbjKCHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345300AbjKCHNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B503186;
        Fri,  3 Nov 2023 00:13:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EDEDC433C8;
        Fri,  3 Nov 2023 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698995617;
        bh=Fll21Zgzn1U5eldaUK5YBY8J95LXL67ovPRyHsdQtZ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pA64Xwk7j89CSsnjj9eBYIvudGKtvxyNjwlo5UTSRC69OCEky2YeWtIAJbhg5erF4
         dS+3rOpRkYMlI913DM5EgbjRCpQGOJCcgz+bnjSEgqrZPb1GC2sLo04DPuWTykFzEk
         pNn6iD6JsmtoWagkh1KpXxXDQCpWu7uBWniNSkpD0Pqp6nUE40DLXluGnI5HF0oFKw
         MnKjT6gxmKXiMCg3c66oxVcdlsnwP7atwUhZv/0SGlJQRTgz+Kdc8kYqstart/YEKN
         yRz1ME1Wx2TcyMyVB7kNRIwpGHUUHZlBzD+vwo4PqEbHoZwA87C+Ek7wtIyH+vbDJe
         ye3+4MNvM5rcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AFB4EAB08A;
        Fri,  3 Nov 2023 07:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101145447.60320c9044e7db4dba2d93e3@linux-foundation.org>
References: <20231101145447.60320c9044e7db4dba2d93e3@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101145447.60320c9044e7db4dba2d93e3@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20231024115206.4ce24d96@canb.auug.org.au fs/bcachefs/btree_cache.c
X-PR-Tracked-Commit-Id: 9732336006764e2ee61225387e3c70eae9139035
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecae0bd5173b1014f95a14a8dfbe40ec10367dcf
Message-Id: <169899561710.26157.18025933232964397970.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 07:13:37 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 14:54:47 -0700:

> https://lkml.kernel.org/r/20231024115206.4ce24d96@canb.auug.org.au fs/bcachefs/btree_cache.c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecae0bd5173b1014f95a14a8dfbe40ec10367dcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
