Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E37D87CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjJZRuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjJZRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:50:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF358B8;
        Thu, 26 Oct 2023 10:50:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47DC436E;
        Thu, 26 Oct 2023 17:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 47DC436E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698342616; bh=EqKA0JXgmnBKYcsb+SfmiAaHk9DpVeGJdzXgW+CLOO4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Zv4dnmKdWlXU3j22mUXRphnyNf9Wcp+wS+0E6hmMj9PkcjraZesBi+26W7Z9KE7++
         L2y9EJmY9TtQmKJsn+deMumtxTxLvOvzJVNF4mX+2MRBulhnFAPtp0IB/DutFEZxI2
         N0pRTmly7469nwsRiC/DM6wWrL1RvKcSKE1ftnNOUf9gxGOGkB66KR05ZGjIDpPcxE
         hSOfhso5VyQUnJdSCyrV0eSfgLyL6X2cLHjkdGmJyGYEF07wzySRdvAcmsmfj/KvHC
         5KnFJUPH1tojPOJvoz1tTauWQsFngZyd2l5UMKmLd0G/tkSBjxU+SyHOWmSWftdJ6b
         FEIVi9C3a0ESw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, Willy Tarreau <w@1wt.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH v2.5] docs: backporting: address feedback
In-Reply-To: <20231023135722.949510-1-vegard.nossum@oracle.com>
References: <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
 <20231023135722.949510-1-vegard.nossum@oracle.com>
Date:   Thu, 26 Oct 2023 11:50:15 -0600
Message-ID: <877cn96zoo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> This addresses a few comments/issues in my v2 submission:
>
> - repeated word: 'run' from kernel test robot
> - emacs/ediff mode from Jon Corbet
> - various comments from Willy Tarreau
> - more backporting advice from Ben Hutchings
> - a couple more cherry-pick tips from Harshit Mogalapalli
> - add a bit about stable submissions
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/process/backporting.rst | 152 ++++++++++++++++++++------
>  1 file changed, 121 insertions(+), 31 deletions(-)

Applied, thanks.

jon
