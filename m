Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A705178146A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380052AbjHRUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380062AbjHRUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EE81712
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 977FC612E7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64C9C433C7;
        Fri, 18 Aug 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391519;
        bh=bDR3L/gJzyPPK1pNdbC1K1vjGO5FNtrIn7o2W0CG1MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHDlbwFYC3UFZ6VpxYSyxRI+F0j0yAMBRRWiLnTO9BOW9oAG0KJ9IOjR5OMm4YxKJ
         cSOc8b83STh6tV7Sv2YuzUWLmABvAtwoJkOU3clD9mmnjURRYTgo88iofqyyTw9uX7
         vsmIV2yGBDVnw6clzIENCunraVb8xrKpqUWRj9BKlG/DVbVNmUUx2cZKwPm3v/cm+R
         KAO5Zw43zutTzni4+Jh0+nnblqnWJT1I+5InovocgEUvAv+eNiohp1x+KteDxUhtaj
         tZaQ2kyfkMn6kjd9U/APJfBGYXkFy718tAiEVj6ewnd/gePjGSBHsOYWUl+QrdN55Q
         NcyXCKJoOXVGg==
Date:   Fri, 18 Aug 2023 21:45:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     werneazc@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v6.6 merge window
Message-ID: <20230818204514.GA1380343@google.com>
References: <20230818083721.29790-2-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818083721.29790-2-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v6.6

for you to fetch changes up to c01467355f8eb126cab0ef28b66bb506fe6a2e21:

  mfd: tps65086: Read DEVICE ID register 1 from device (2023-08-18 21:43:02 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v6.6 merge window

----------------------------------------------------------------
Andre Werner (1):
      mfd: tps65086: Read DEVICE ID register 1 from device

 drivers/mfd/tps65086.c       | 17 ++++++++++++-----
 include/linux/mfd/tps65086.h | 20 ++++++++++++++------
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
Lee Jones [李琼斯]
