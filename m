Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38BB790C7C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 16:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbjICOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjICOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 10:37:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D414F4;
        Sun,  3 Sep 2023 07:37:41 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E4DF1EC059E;
        Sun,  3 Sep 2023 16:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693751853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LDkGfdZhuMUtbz0/tWppN9J8rD/qqqEJXIDsC7GOjGU=;
        b=dKD4LPye9HMYPYInI9ft6mSk3O9rBN/adnpAE7AVSWm+Blrku/X7zHGo3OXLGN3STevWsA
        QuKXX+fomU+89iQqr3Fu8GElWxptfjwww4XkulqovB9Z5srD0DMRtF8rwZVu9d/0JIriye
        rpj/FzzD06ExJbEZbkBtz9kEdglllMk=
Date:   Sun, 3 Sep 2023 16:37:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/bugs] x86/srso: Fix vulnerability reporting for
 missing microcode
Message-ID: <20230903143729.GAZPSaKWzNv/IcyMvk@fat_crate.local>
References: <65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org>
 <169295877252.27769.17888941552572030723.tip-bot2@tip-bot2>
 <20230901094053.GDZPGxpcG56GwE0LyG@fat_crate.local>
 <ZPMSbabIw5ZtTqbo@gmail.com>
 <5D92E1C0-EB00-4D24-AA4F-A616244C32D5@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5D92E1C0-EB00-4D24-AA4F-A616244C32D5@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 08:04:07PM +0300, Borislav Petkov wrote:
> Ok, sounds good. Give  me a while to go through the rest first. I'll
> let you guys know. Reviewing with a slow, ancient laptop is not the
> easiest thing in the world...

Ok, apart from the couple of small things I mentioned, this cleanup
looks good, thanks Josh!

Pls send a new version with the feedback addressed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
