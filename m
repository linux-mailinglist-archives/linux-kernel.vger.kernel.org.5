Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C718D7E745C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjKIW2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjKIW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:28:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD03C01;
        Thu,  9 Nov 2023 14:28:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92061C43391;
        Thu,  9 Nov 2023 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699568898;
        bh=1Q9spJVVUWUF5CR0oYTZPyDaBTIOohjjClKZaK2jfUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QesGB+Sx0b8OR7AR7vI3/TiCLF1qH+kaJJdvYHPlUfjbXagLyxZNLFYdDcaS0vDfd
         1VnFtZgBBlh2MzyloXfRlwR/hXk4dL/DAU7DeY6t3Dh1vPbFwL77tNmYGi2zPXkwq1
         h6wxX1RDINyl+PugJAv8tJQhODzD8g0t5qB9ykGmWLT+Cxa0Q4AI8K6TNuFXyItU1E
         HLwZST2cxpVpZPnPK0Ie3inhteZTPIENB7ibreMHRuRPlcGqF5iJfjMsvllci3e45i
         8qmn5/wZTYv6xfueRfVOaTXLcVqUVKxLOEa/c3RH8jFk/OPPWpSaUs6uskQlXoaI19
         5NPvsOgYZ6YMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80AB7C43158;
        Thu,  9 Nov 2023 22:28:18 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.7-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUyey2l2Cfri8715@google.com>
References: <ZUyey2l2Cfri8715@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUyey2l2Cfri8715@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.7-rc0
X-PR-Tracked-Commit-Id: cdd5b5a9761fd66d17586e4f4ba6588c70e640ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a12deb44f9734dc25970c266249b272e44d3d1b5
Message-Id: <169956889852.16549.17169214396540146141.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Nov 2023 22:28:18 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Nov 2023 00:56:43 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.7-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a12deb44f9734dc25970c266249b272e44d3d1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
