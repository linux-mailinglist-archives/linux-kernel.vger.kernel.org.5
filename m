Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0797D01C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346379AbjJSSgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346450AbjJSSgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:36:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE87130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:36:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7E59C433CA;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697740576;
        bh=ZbOL/C/VNWy+53xiRgBBndhAT8gctkkRJfqEABWbbxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TV93abW/Mrt+ZcJyeBLTuFaUCyvdeHFy6N0kfhAWsUSxIIo/rzPNaRrRqUeDv9/Ee
         dMGVEVz49qiG0GEEi3qDB/OzFJwEBbizwUVyeIJ6LxU5RKv4HMjKxfG3WuGueQQW23
         wiID8/u9glImg1GfFnPZfjfsuF2zJMzt7Nf+h1J6Ig0120cmuY0Y+EGMnlaxCBscf6
         y0oZNeesZcrYJ7Za5jr35M0q7mTu7JrlVVbavd1qiR21AebutLQa1LewqTEjTufATU
         I3X9gnEZYpOctKh+OFxudndzhnhXVuBxxUXu0tsjt4nTrDS+bjyZ7Z/4cc3E0yRtng
         eH5w3i8GtbYMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAA82C73FE2;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231019-kampfsport-metapher-e5211d7be247@brauner>
References: <20231019-kampfsport-metapher-e5211d7be247@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231019-kampfsport-metapher-e5211d7be247@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc7.vfs.fixes
X-PR-Tracked-Commit-Id: 03adc61edad49e1bbecfb53f7ea5d78f398fe368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1cc20cd4ce55dd920a87a317c43da03ccea192
Message-Id: <169774057669.20290.2402889102642037711.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Oct 2023 18:36:16 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Oct 2023 12:07:08 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc7.vfs.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1cc20cd4ce55dd920a87a317c43da03ccea192

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
