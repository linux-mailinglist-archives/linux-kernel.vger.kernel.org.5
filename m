Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB97D16F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjJTU1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjJTU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF0D65
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:27:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D11AC433C8;
        Fri, 20 Oct 2023 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697833629;
        bh=FPdh8hIK26IDcC01lJq3rd+ljmTHrQuDis2XL9mvZYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bfg42l1ymQfJkru4cyMZelb9sSqH4nxiajDyuOURNQ50nv6+SKoGniA562vfOIwq2
         UU9D5+QcZ/rsFCQxYSK9X0fFWGCU+gqj+huxOjq7HuRlZcrClm2IvZnTmXQL2PDWF8
         CG0GZ7+ePvD9C3SioMSilyBOItTvvXlm9lqeIgGYdH3M22LzklEH0124O0ZVcWRYxZ
         pTmapi4rrUC/X/o3/qunS/D/+VG8TJu4ph/6ZUOV0FVgTdfUmekJVMcjxguy6BVVYO
         RnvBLV0xHJ21A4Rk0d86IiM5mu/AqcD3oONRtBEvCR4blMeG26uJtSb1BhMNUdu+eQ
         qNwX+zZ4ofxew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C590C595CB;
        Fri, 20 Oct 2023 20:27:09 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231020200039.09ff7f18@xps-13>
References: <20231020200039.09ff7f18@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20231020200039.09ff7f18@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.6-rc7
X-PR-Tracked-Commit-Id: f6ca3fb6978f94d95ee79f95085fc22e71ca17cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6176471542d991137543af2ef1c18dae3286079
Message-Id: <169783362930.7501.3159683129456792015.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 20:27:09 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 20:00:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6176471542d991137543af2ef1c18dae3286079

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
