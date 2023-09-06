Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101A793793
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjIFJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjIFJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:00:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C1197
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:00:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52462C433C8;
        Wed,  6 Sep 2023 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693990801;
        bh=WOGAWS13sQQwB2RID/SlKfczvn6KIrFrTl+18tFhlv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNsMPYvudd2+uXKb9r06cmVskzu+oeUqQr+InBIyxyYr72aFXouocRlOdoZ5pHoLf
         gcK/R4LEcH1RtShHaLLHDkQCfiqpF3llFU8h8duR0fbd+SBvGRMfT0BZSGc+MDDY4Y
         j9pGJrZp0taSPN3ruOTdxE7fMzabs5uN/yNkOXKQw4NQBEGMYS7So/mSkpg/P7QxX6
         Fe8znob9dFA/CiPy3abaPziktJlMqb7U/Z8jkCdS0S0/+6xX4Vm3FxhOQxZWob+jVg
         vtl9yO6Ktv9Cy05hq2BL/HBtpHn85jHOC+/9ABEu/cTQO0pep3WErnHQ1saoNia/e6
         OivWJpuDDa8bw==
Date:   Wed, 6 Sep 2023 09:59:57 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] MFD for v6.6
Message-ID: <20230906085957.GH13143@google.com>
References: <20230904140444.GA13143@google.com>
 <CAHk-=wg-tX4YBjr2MOa=3pJz6wr2rG1nYDNwDC-vtUo4eeTtAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg-tX4YBjr2MOa=3pJz6wr2rG1nYDNwDC-vtUo4eeTtAw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023, Linus Torvalds wrote:

> On Mon, 4 Sept 2023 at 07:04, Lee Jones <lee@kernel.org> wrote:
> >
> >  - New Drivers
> >    - Add support for the Cirrus Logic CS42L43 Audio CODEC
> 
> .. this had apparently already come in through the spi tree (although
> Mark incorrectly called it the CS43L43 ;).

Yes, we shared an immutable branch between us.

-- 
Lee Jones [李琼斯]
