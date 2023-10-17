Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81437CC933
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbjJQQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJQQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:55:49 -0400
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F256FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1697561725; bh=9R7kdHrk4PfJpyjOHkzWVMHbfP3j4XMlZ6FNYE9dp1U=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Afqaf32okUz9JMUIp3KpD4GNbhkW1PvhvXqC69ZOVB1E0soepMNkVOk5Im1S4cVbT
         nTs9kFppm2fKJWjTQfQlgfTnB0F8nlgokM1oBXtgukYxmHWaKvXNujvI6oyTXPkacj
         wtW1YhVuJDle1sw/lDPCc+9pW/aoKq3aS/g85Nx8=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Tue, 17 Oct 2023 18:55:25 +0200 (CEST)
X-EA-Auth: Bxp/TsMXdHyLjnEPIBmXD+0Sjoq5Ragm5L0nLHqhQ1CLC1eg1Oat3vKc45p/38j91pXPtSoRkOC5FycF/7syT0We1WX+X7CN
Date:   Tue, 17 Oct 2023 22:25:19 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Deepak R Varma <drv@mailo.com>
Subject: Re: ivpu TODO list items
Message-ID: <ZS68dysac34rA32D@runicha.com>
References: <ZSjwuyCOL9Vb9+yb@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSjwuyCOL9Vb9+yb@runicha.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:54:43PM +0530, Deepak R Varma wrote:
> Hello,
> I am shortlisted as a mentee for the LF Mentorship program. I looked at the TODO
> file for the ivpu driver for my project tasks. Could you please answer the
> following questions:
>
> 1. Is the TODO list up to date? If not, can we have it updated? Let me know if I
> can help.
> 2. Is it absolutely necessary for me to have a specialized hardware to test my
> patches? Is it limited to the 14thGen or above CPU or do I need more than that?
> 3. Is it okay for me to work on the TODO list items. Let me know if you have a
> preference [Please note I just started a few months ago and still learning].

Hello,
May I request the maintainer to review my questions and comment please?

Thank you,
Deepak.

>
>
> Thank you in advance.
> Deepak.


