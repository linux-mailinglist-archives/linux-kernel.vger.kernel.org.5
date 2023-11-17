Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC057EF471
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjKQO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:29:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14023B8;
        Fri, 17 Nov 2023 06:29:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B306C433C7;
        Fri, 17 Nov 2023 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700231340;
        bh=xQuC6Jvfo0Of8B33Yv/38dKbdxjnoPlyeFBrD4qVPk0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PS4jM8GbjiiSizZTakgFDYGle9YKvHK6zWJi7oZ4N2f5wGkAIkjGfrWlFlJl5ugkq
         WSljMmXclwhsTJAQAnkJxO2EJY+1rSqquqBADbBvy/9Q7J5GAchIn8pEXCcdt9+M+6
         EkrgKYI1+cMYo36i0gcNOORxZTxxcxvpKeDpOkpU9S2OdxrF9LdqSRi8zOBnwSZOgo
         1w41fwH6fzJm0fB8ret0GBaoGF7YUILJiJ3x3dYciArcXEcVDG+o9ppA304uuUiKI0
         vFAn5akcKmXXvblH3W+U4UQDek0JN0AoGi1iIvQNdmPFYFsOujopdRks8GdaIoemdI
         JuOaTgbJSh6rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 898E9C4316B;
        Fri, 17 Nov 2023 14:29:00 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231117131315.1927413-1-amir73il@gmail.com>
References: <20231117131315.1927413-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231117131315.1927413-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc2
X-PR-Tracked-Commit-Id: 37f32f52643869131ec01bb69bdf9f404f6109fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bc40e44f1ddef16a787f3501b97f1fff909177c
Message-Id: <170023134055.28622.6849058513211945485.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Nov 2023 14:29:00 +0000
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Nov 2023 15:13:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bc40e44f1ddef16a787f3501b97f1fff909177c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
