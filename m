Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0475DE20
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjGVSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGVSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D896211E;
        Sat, 22 Jul 2023 11:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1201660677;
        Sat, 22 Jul 2023 18:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73E4DC433C8;
        Sat, 22 Jul 2023 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690052011;
        bh=ElkfNjyeK/aOBy5OYtmfAy/g3JU3qxJ3osaL4RmhO2A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZSStsp+Am6ljb3OuwA6cHkQyBKDaWP1lAPl3n/XALZAF+hNuMIpkcZUNX2XrvYMic
         cl70RJC9yoTQuzO0SBq5al+R4MtAP6a8rOjwzIC27sg+a+5/irlsDy4AVRapkY6rJX
         gdtEnbRQMMnRm2W3l0FQaBn+eMr0SvfAD/H85tY9+dTk3SUE5H9iJaS/qDnUI7N8sC
         nwZ4eoxladAJ1wm3IDJ8Vy9CN3MDtA/8xJdxv7O/PQbbF1JnbSV2O0u49pgc7aybWy
         cZwiwb79anoKD5LeIVktulVGKNS9mYLvsIkPeDMbve6YUwF72vW3q6A7JUggmxWWOq
         AKYeCU3THjnGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60278C595C3;
        Sat, 22 Jul 2023 18:53:31 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230722160215.7417-A-hca@linux.ibm.com>
References: <20230722160215.7417-A-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230722160215.7417-A-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-3
X-PR-Tracked-Commit-Id: 4cfca532ddc3474b3fc42592d0e4237544344b1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 295e1388de2d5c0c354adbd65d0319c5d636c222
Message-Id: <169005201138.23354.7673878633795209202.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jul 2023 18:53:31 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jul 2023 18:02:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/295e1388de2d5c0c354adbd65d0319c5d636c222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
