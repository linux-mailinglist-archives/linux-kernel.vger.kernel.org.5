Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184A28073A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379119AbjLFPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbjLFPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:21:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD929A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:21:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51A6C433C7;
        Wed,  6 Dec 2023 15:21:57 +0000 (UTC)
Date:   Wed, 6 Dec 2023 16:21:54 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for v6.7-rc5
Message-ID: <ZXCRkjpftWJwIbpk@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a single line patch for parisc which fixes the build
in tinyconfig configurations.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc5

for you to fetch changes up to 487635756198cad563feb47539c6a37ea57f1dae:

  parisc: Fix asm operand number out of range build error in bug table (2023-11-27 11:01:38 +0100)

----------------------------------------------------------------
parisc architecture fix for kernel v6.7-rc5:

- Fix asm operand number out of range build error in bug table

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix asm operand number out of range build error in bug table

 arch/parisc/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
