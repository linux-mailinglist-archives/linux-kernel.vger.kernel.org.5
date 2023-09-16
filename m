Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840687A3217
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjIPTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbjIPTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:00:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467C6C7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 187F5C43395;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694890816;
        bh=sIp41fVoPgffH1qOcV9gSsBIhctjbuX3pmGBSxP0XIo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d64wwx1aXRLG5w1SojYtzlxNLJp4kffm5ZlfosdatZ2HfYXTnhlND7gPaQFk1LnpK
         ZXaIFXBoB9zkT1i/MlZ2TqY51Yq5kY6DiL4xBOdgreoHq2YpKg/VBKu33qvUSLWBfu
         FtNShKq6tgi2yIrCwowSSWKWy4Jyem79fX+uAF4FulyG9PqBfM2diIVQC1/xG0i2xB
         ZASddr3oZ+736+Ntfjw0qhCQmAt5BGbPTC46AKc6W6F1jA5KPg2RPM3yM/kBJDZd1+
         flAMDf7ZOtP0HnfX0FQsGlN390+nNsTy+Ru7QlThGQgfFyC1UxNyF0QG/yemppL+SA
         E9w51YBYLA5Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00350E26884;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
Subject: Re: [GIT PULL] USB fix for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQWYu7xf_8KTWXFu@kroah.com>
References: <ZQWYu7xf_8KTWXFu@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQWYu7xf_8KTWXFu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc2
X-PR-Tracked-Commit-Id: f26a679ed799deef9e2934a6b60b8f38bdbf4921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cce67b6bedd3e28939446508ebd94d91305b8ace
Message-Id: <169489081599.3998.8454913923088827295.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 19:00:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Sep 2023 13:59:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cce67b6bedd3e28939446508ebd94d91305b8ace

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
