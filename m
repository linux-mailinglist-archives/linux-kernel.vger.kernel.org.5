Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9776EF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjHCQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjHCQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E930D3;
        Thu,  3 Aug 2023 09:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D0661E2F;
        Thu,  3 Aug 2023 16:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C4DC433C9;
        Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080245;
        bh=+Cx6D7YgBdq4sB54INc4/bcMADVz+UJqomdkMI8E7bQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DwaiaJQpzQot1HmsuMEoAPoZify2ixdm3WERdR7gBymXL6DX5twEiCMhOJ3AaOzme
         bsCkJH9lEzgUViU1qgX3q8HgZ3VvxdoCe4VFWKlvSd4KH4PCpvERJljkmiXIPR3DOm
         ImaAM993UrYSQT7in3/Jkfcp83cMwRw63u0rQ1DVgnxWti27XKkkhme/crduDIhoJp
         cY62NNjfo3jLdwPh4tdpBV5P4E05qKc0rKM9UoVPl8byBS/sd2ovdwl3CfQ5yyyNRg
         L06g4fy9YrXCzm1HFlJ17+31dOYPh/SorF90vl1oRPp0S4AYV2KnU8lsBCkj0qiimO
         ddNq1paeWJRrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 944D6C3274D;
        Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230803074742.9170-C-hca@linux.ibm.com>
References: <20230803074742.9170-C-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230803074742.9170-C-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-4
X-PR-Tracked-Commit-Id: 388acb471662c273d94163a8502f09668f380686
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e0ba145952328bf1a9c2f0be0bd59a9cc5a7b21
Message-Id: <169108024559.31872.6929868768453286379.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Aug 2023 16:30:45 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Aug 2023 09:47:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e0ba145952328bf1a9c2f0be0bd59a9cc5a7b21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
