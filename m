Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6156A7E121F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjKEDCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 23:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjKEDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 23:02:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B60F184
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 20:02:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 336FDC433C7;
        Sun,  5 Nov 2023 03:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699153322;
        bh=R0ufgtveFKAiLDHjsManiSwk89jg61U2l+W1ZS5uOME=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sm62zHKz6v4V4VsngVRbufGdFyC3/BjnyFj7Ic8nk4oHxq0E9my2HNDBV8cp+Fcgj
         C0tMpMkG3f6fuBJ/VXdwLbanGrmRUEdfabSJHHCqy6HeF2qinQ12qscn+NEuenpt8K
         IKYG97it73KbR3XXAoP7ZM7OotIzgmiso0dkygq/VuZwcSteiffI6v/etxetIxfiv2
         KpaHPqZaWWadb0rdvtBGQ5kcUaUzhxDjas1YxqYh6RUFhR0iv43XJA6+Z0As6MtxOt
         cqqZbPKez6R9+Lx/Lj7oO0hiEdnaAutQGEGrATZ2RRqcq9LrbKvunNtJ7cO04sIjCy
         aofNcO3JQGOSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23433EAB08A;
        Sun,  5 Nov 2023 03:02:02 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231104120719.185834dc@xps-13>
References: <20231104120719.185834dc@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20231104120719.185834dc@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.7
X-PR-Tracked-Commit-Id: 6d55d31e927eec68ba6db344688044ed253223e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1dfbda8636b54cde21f9f5d352fd25c4deff584
Message-Id: <169915332213.2133.4033974515584445366.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 03:02:02 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Nov 2023 12:07:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1dfbda8636b54cde21f9f5d352fd25c4deff584

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
