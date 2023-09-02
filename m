Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AE7905F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351816AbjIBHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbjIBHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:45:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4751737;
        Sat,  2 Sep 2023 00:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66A2CCE25A0;
        Sat,  2 Sep 2023 07:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4571CC433C8;
        Sat,  2 Sep 2023 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640714;
        bh=cJ/h9MEwLxaWCTYXWc6f5EkX4OodMswztIwBzLR5OvY=;
        h=From:To:Cc:Subject:Date:From;
        b=j6ZcNbrdIxKzbZCvmiyt6c57gyLLVPaj5BmcOx4zd9emIW4X0pTtGk8QHj1YgMLy0
         HJbi5QK9E0TemSd1Eu7GumHerAnOQqcOgLqtjMLiu7q6sW5JAZmd//oPYyv3mHmk1N
         y3NDtbxafPSjwjntFmHtRJ06/P1eA8PdPXzL+CW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.325
Date:   Sat,  2 Sep 2023 09:45:06 +0200
Message-ID: <2023090206-dimness-twelve-1bff@gregkh>
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

I'm announcing the release of the 4.14.325 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
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
      Linux 4.14.325

