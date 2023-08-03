Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2906F76F5DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHCWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHCWwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388B7BA;
        Thu,  3 Aug 2023 15:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80DF61EE1;
        Thu,  3 Aug 2023 22:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38490C433C9;
        Thu,  3 Aug 2023 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691103163;
        bh=gM+TqSMjRR8r7fwnGJdopx4jEc13lUFVfBlUOE8xNDI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ze3tQuThTdm3LYI5lLazxHSvUkojMcomluGJ2gecmVVrmRnko9dUFdjfjMm6GyAdv
         63zt0lnDiK21Be0e8GuFbNWiTIu4OJkZNEEtix5Wl6UfVLbDVBOfEO17fp+lrhdoqc
         6yMaXYzF6sNZwtITNeNOupxmnEKD+XCXFkaRlJ5/dfYwphDLP0n/KA3mfiMBRV6eBo
         uOJLN5INsLgTALuINEcKvDJrI3+kGSWLv5+Lf4B28nmqcBLXuFwOeyXj0ID2ewAePS
         4iNAapBZdPjnvH9Ydm1CqNQljyqJzBx1yNcVgzA+U7xE2Biro+KPjOGkHnFUKnWTg4
         GS868MIcR4lQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D0CC41620;
        Thu,  3 Aug 2023 22:52:43 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9689a32a5b56cd5521cd8ae3c2530329bc820cde.camel@intel.com>
References: <9689a32a5b56cd5521cd8ae3c2530329bc820cde.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9689a32a5b56cd5521cd8ae3c2530329bc820cde.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.5-rc5
X-PR-Tracked-Commit-Id: ad64f5952ce3ea565c7f76ec37ab41df0dde773a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 638c1913d2b01ab48159f0723fbf98483579934f
Message-Id: <169110316314.15224.1929073039478678975.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Aug 2023 22:52:43 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Aug 2023 17:41:50 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/638c1913d2b01ab48159f0723fbf98483579934f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
