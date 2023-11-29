Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F847FDB61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjK2P05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjK2P0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:26:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76A19BA;
        Wed, 29 Nov 2023 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PKsQMbsN0QWAKv2jNMdgGwhjrNCW6BNWUDQ6YRpuRlU=; b=RmoM01ItmuKnUSVmpIbPI2bH9v
        mhHqH5GExVaD/VgR54BoKqfFiSHoIjiv8yR8/mTDccz83ix4DJdUG1hMwyWu7kWY5gTxuJUQZZDG3
        ScImQjVoDyS6rAZ7PX04g5yKujaPDgidrgRG8UyAyFBHPKp0A526tzffKHkqbkMh3Qe1h6wHiahLw
        ORT7OLZykfqOnoL9DSsTc/DA0rxSJtyptnBJiHoHG1LchC+ySlRIpgR7VfXVBQTurWfvb946VW7vG
        +DUwO3w4ytXX1siY+Mababr6ncli+KGytLrsQqBeH3gX2KOBqyk9H/+6GlBgNtVmLi+Samj6OzwfL
        EsKQQaOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8MSA-00DWNO-Uk; Wed, 29 Nov 2023 15:26:18 +0000
Date:   Wed, 29 Nov 2023 15:26:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Attreyee Mukherjee <tintinm2017@gmail.com>,
        Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Message-ID: <ZWdYGrhTYFzG5BZq@casper.infradead.org>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <874jh4pr8w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jh4pr8w.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 07:29:35AM -0700, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > I was prompted to write this little grammar fix series when reading
> > the fix from Attreyee [1], with review comments requesting changes
> > to that fix. So here's my version of the fix, with reviews from [1]
> > addressed (and distinct grammar fixes splitted).
> 
> How is this helpful?  Why are you trying to push aside somebody who is
> working toward a first contribution to the kernel?  This is not the way
> to help somebody learn to work with the kernel community.

This is not the first such "contribution" from Bagas recently.

https://lore.kernel.org/linux-doc/20231121095658.28254-1-bagasdotme@gmail.com/

was as a result of
https://lore.kernel.org/linux-xfs/87r0klg8wl.fsf@debian-BULLSEYE-live-builder-AMD64/

I didn't say anything at the time, but clearly I should have squelched
this bad behaviour by Bagas before he did it to a newbie.

Bagas, find your own project to work on.  Don't steal glory from others.
