Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325817905EE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351778AbjIBHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbjIBHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:45:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246A1985;
        Sat,  2 Sep 2023 00:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F6B4B8275F;
        Sat,  2 Sep 2023 07:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C958DC433C8;
        Sat,  2 Sep 2023 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640707;
        bh=q/TXt6tXy/zhDceM4A1GiFMQCPpUen4LhzeMso492yA=;
        h=From:To:Cc:Subject:Date:From;
        b=W/lL7TM/b8ZrYRYBQ9wVNl4nxtsvOeGnLeUI6xk5tzmlW5mnr84ZrchHVtmvx6f+4
         v1SWxVAyuRrg27fLuKilFOrG0i39iJ4hZ6qWIGjGRh8AJjGb45niQ8ZzxR6xpUQDd6
         Wva7W6u5Mdt/uGuYl5xYfIcDtBgHw58Bh9oYzEYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.294
Date:   Sat,  2 Sep 2023 09:45:00 +0200
Message-ID: <2023090259-humbly-theater-4cbf@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.294 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                            |    2 +-
 arch/arm/mach-ep93xx/timer-ep93xx.c |    3 +--
 arch/mips/alchemy/common/dbdma.c    |   27 ++++++++++++---------------
 3 files changed, 14 insertions(+), 18 deletions(-)

Greg Kroah-Hartman (3):
      Revert "MIPS: Alchemy: fix dbdma2"
      Revert "ARM: ep93xx: fix missing-prototype warnings"
      Linux 4.19.294

